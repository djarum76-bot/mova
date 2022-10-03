package models

import (
	"database/sql"
	"mova/db"
	"net/http"

	"github.com/lib/pq"
)

func CheckUsernamePhone(username string, phone string) int {
	var user User
	var err error
	var pwd sql.NullString

	con := db.CreateCon()

	sqlStatement := "SELECT * FROM users WHERE username = ($1) OR phone = ($2)"

	err = con.QueryRow(sqlStatement, username, phone).Scan(&user.Id, &user.Uid, &user.Username, &user.Email, &user.Phone, &user.KeyName, &user.Picture, &user.CreatedAt, &user.Pin, pq.Array(&user.Interest), &pwd)
	if err == sql.ErrNoRows {
		return http.StatusOK
	} else {
		return http.StatusInternalServerError
	}
}

func CheckEmail(email string) int {
	var user User
	var err error
	var pwdHash sql.NullString

	con := db.CreateCon()

	sqlStatement := "SELECT * FROM users WHERE email = ($1)"

	err = con.QueryRow(sqlStatement, email).Scan(&user.Id, &user.Uid, &user.Username, &user.Email, &user.Phone, &user.KeyName, &user.Picture, &user.CreatedAt, &user.Pin, pq.Array(&user.Interest), &pwdHash)
	if err == sql.ErrNoRows {
		return http.StatusOK
	} else {
		return http.StatusInternalServerError
	}
}
