package models

import (
	"database/sql"
	"io"
	"mime/multipart"
	"mova/db"
	"net/http"
	"os"
	"time"

	"github.com/golang-jwt/jwt"
	"github.com/lib/pq"
)

func GenerateNewToken(email string, uid string) (map[string]string, bool, error) {
	var user User
	var err error
	var pwd sql.NullString

	con := db.CreateCon()

	sqlStatement := "SELECT * FROM users WHERE email = ($1) AND uid = ($2)"

	err = con.QueryRow(sqlStatement, email, uid).Scan(&user.Id, &user.Uid, &user.Username, &user.Email, &user.Phone, &user.KeyName, &user.Picture, &user.CreatedAt, &user.Pin, pq.Array(&user.Interest), &pwd)
	if err == sql.ErrNoRows {
		return map[string]string{
			"error": err.Error(),
		}, false, err
	}
	if err != nil {
		return map[string]string{
			"error": err.Error(),
		}, false, err
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
		return map[string]string{
			"error": err.Error(),
		}, false, err
	}

	res := map[string]string{
		"token": t,
	}

	return res, true, nil
}

func GetUser(id string) (Response, error) {
	var user User
	var err error
	var res Response

	con := db.CreateCon()

	sqlStatement := "SELECT id, uid, username, email, phone, keyName, picture, createdAt, pin, interest FROM users WHERE id = ($1)"

	err = con.QueryRow(sqlStatement, id).Scan(&user.Id, &user.Uid, &user.Username, &user.Email, &user.Phone, &user.KeyName, &user.Picture, &user.CreatedAt, &user.Pin, pq.Array(&user.Interest))
	if err == sql.ErrNoRows {
		return res, err
	}
	if err != nil {
		return res, err
	}

	res.Status = http.StatusOK
	res.Pesan = "Berhasil Get Data User"
	res.Data = user

	return res, nil
}

func EditProfileWithPicture(id string, picture *multipart.FileHeader, username string) (Response, error) {
	var user User
	var err error
	var res Response

	con := db.CreateCon()

	sqlStatement := "UPDATE users SET username = ($1), picture = ($2) WHERE id = ($3)"

	//picture
	src, err := picture.Open()
	if err != nil {
		return res, err
	}
	defer src.Close()

	pictureUrl := "profile/" + picture.Filename

	dst, err := os.Create(pictureUrl)
	if err != nil {
		return res, err
	}
	defer dst.Close()

	if _, err = io.Copy(dst, src); err != nil {
		return res, err
	}

	_, err = con.Exec(sqlStatement, username, pictureUrl, id)
	if err != nil {
		return res, err
	}

	user.Username = username
	user.Picture = sql.NullString{
		String: pictureUrl,
		Valid:  true,
	}

	res.Status = http.StatusOK
	res.Pesan = "Berhasil Edit Profile"
	res.Data = map[string]interface{}{
		"username": user.Username,
		"picture":  user.Picture,
	}

	return res, nil
}

func EditProfileWithoutPicture(id string, username string) (Response, error) {
	var user User
	var err error
	var res Response

	con := db.CreateCon()

	sqlStatement := "UPDATE users SET username = ($1) WHERE id = ($2)"

	_, err = con.Exec(sqlStatement, username, id)
	if err != nil {
		return res, err
	}

	user.Username = username

	res.Status = http.StatusOK
	res.Pesan = "Berhasil Edit Profile"
	res.Data = map[string]interface{}{
		"username": user.Username,
	}

	return res, nil
}
