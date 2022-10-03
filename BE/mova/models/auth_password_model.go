package models

import (
	"database/sql"
	"io"
	"mime/multipart"
	"mova/db"
	"mova/helper"
	"net/http"
	"os"
	"time"

	"github.com/golang-jwt/jwt"
	"github.com/lib/pq"
)

func RegisterPasswordWithPicture(uid string, username string, email string, phone string, keyName string, picture *multipart.FileHeader, createdAt string, pin string, interest []string, password string) (ResponseToken, bool, error) {
	var user User
	var err error
	var res ResponseToken
	var id int

	con := db.CreateCon()

	sqlStatement := "INSERT INTO users (uid, username, email, phone, keyName, picture, createdAt, pin, interest, password) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10) RETURNING id"

	//picture
	src, err := picture.Open()
	if err != nil {
		return res, false, err
	}
	defer src.Close()

	pictureUrl := "profile/" + picture.Filename

	dst, err := os.Create(pictureUrl)
	if err != nil {
		return res, false, err
	}
	defer dst.Close()

	if _, err = io.Copy(dst, src); err != nil {
		return res, false, err
	}

	err = con.QueryRow(sqlStatement, uid, username, email, phone, keyName, pictureUrl, createdAt, pin, pq.Array(interest), password).Scan(&id)
	if err != nil {
		return res, false, err
	}

	user.Id = id
	user.Uid = uid
	user.Username = username
	user.Email = email
	user.Phone = phone
	user.KeyName = keyName
	user.Picture = sql.NullString{
		String: pictureUrl,
		Valid:  true,
	}
	user.CreatedAt = createdAt
	user.Pin = pin
	user.Interest = interest

	claims := &JwtCustomClaims{
		user.Id,
		user.Uid,
		user.Username,
		user.Email,
		user.Phone,
		user.Picture,
		jwt.StandardClaims{
			ExpiresAt: time.Now().Add(time.Hour * 720).Unix(),
		},
	}

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)

	t, err := token.SignedString([]byte("secret"))
	if err != nil {
		return res, false, err
	}

	res.Status = http.StatusOK
	res.Pesan = "Berhasil Register dari password"
	res.Data = user
	res.Token = t

	return res, true, nil
}

func RegisterPasswordWithoutPicture(uid string, username string, email string, phone string, keyName string, createdAt string, pin string, interest []string, password string) (ResponseToken, bool, error) {
	var user User
	var err error
	var res ResponseToken
	var id int

	con := db.CreateCon()

	sqlStatement := "INSERT INTO users (uid, username, email, phone, keyName, picture, createdAt, pin, interest, password) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10) RETURNING id"

	err = con.QueryRow(sqlStatement, uid, username, email, phone, keyName, nil, createdAt, pin, pq.Array(interest), password).Scan(&id)
	if err != nil {
		return res, false, err
	}

	user.Id = id
	user.Uid = uid
	user.Username = username
	user.Email = email
	user.Phone = phone
	user.KeyName = keyName
	user.Picture = sql.NullString{
		Valid: false,
	}
	user.CreatedAt = createdAt
	user.Pin = pin
	user.Interest = interest

	claims := &JwtCustomClaims{
		user.Id,
		user.Uid,
		user.Username,
		user.Email,
		user.Phone,
		user.Picture,
		jwt.StandardClaims{
			ExpiresAt: time.Now().Add(time.Hour * 720).Unix(),
		},
	}

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)

	t, err := token.SignedString([]byte("secret"))
	if err != nil {
		return res, false, err
	}

	res.Status = http.StatusOK
	res.Pesan = "Berhasil Register dari password"
	res.Data = user
	res.Token = t

	return res, true, nil
}

func LoginPassword(email string, password string) (ResponseToken, bool, error) {
	var user User
	var res ResponseToken
	var err error
	var pwdHash string

	con := db.CreateCon()

	sqlStatement := "SELECT * FROM users WHERE email = ($1)"

	err = con.QueryRow(sqlStatement, email).Scan(&user.Id, &user.Uid, &user.Username, &user.Email, &user.Phone, &user.KeyName, &user.Picture, &user.CreatedAt, &user.Pin, pq.Array(&user.Interest), &pwdHash)
	if err == sql.ErrNoRows {
		return res, false, err
	}
	if err != nil {
		return res, false, err
	}

	match, err := helper.CheckPasswordHash(pwdHash, password)
	if !match {
		return res, false, err
	}

	claims := &JwtCustomClaims{
		user.Id,
		user.Uid,
		user.Username,
		user.Email,
		user.Phone,
		user.Picture,
		jwt.StandardClaims{
			ExpiresAt: time.Now().Add(time.Hour * 720).Unix(),
		},
	}

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)

	t, err := token.SignedString([]byte("secret"))
	if err != nil {
		return res, false, err
	}

	res.Status = http.StatusOK
	res.Pesan = "Berhasil Login dari password"
	res.Data = user
	res.Token = t

	return res, true, nil
}
