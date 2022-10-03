package models

import (
	"database/sql"
	"mova/db"
	"net/http"
)

func AddComment(film_id int, user_id int, user_uid string, username string, picture sql.NullString, comment string, createdAt string) (Response, error) {
	var comments Comments
	var res Response
	var err error
	var id int

	con := db.CreateCon()

	sqlStatement := "INSERT INTO comments (film_id, user_id, user_uid, username, picture, comment, createdAt) VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING id"

	if picture.Valid {
		err = con.QueryRow(sqlStatement, film_id, user_id, user_uid, username, picture, comment, createdAt).Scan(&id)
	} else {
		err = con.QueryRow(sqlStatement, film_id, user_id, user_uid, username, nil, comment, createdAt).Scan(&id)
	}
	if err != nil {
		return res, err
	}

	comments.Id = id
	comments.FilmId = film_id
	comments.UserId = user_id
	comments.UserUID = user_uid
	comments.Username = username
	comments.Picture = picture
	comments.Comment = comment
	comments.CreatedAt = createdAt

	res.Status = http.StatusOK
	res.Pesan = "Berhasil Add Comment"
	res.Data = comments

	return res, nil
}

func GetAllComment(film_id string) (Response, error) {
	var res Response
	var err error
	var comments Comments
	arrComments := []Comments{}

	con := db.CreateCon()

	sqlStatement := "SELECT * FROM comments WHERE film_id = ($1) ORDER BY createdAt DESC"

	rows, err := con.Query(sqlStatement, film_id)
	if err != nil {
		return res, err
	}
	defer rows.Close()

	for rows.Next() {
		err = rows.Scan(&comments.Id, &comments.FilmId, &comments.UserId, &comments.UserUID, &comments.Username, &comments.Picture, &comments.Comment, &comments.CreatedAt)
		if err != nil {
			return res, err
		}

		arrComments = append(arrComments, comments)
	}

	res.Status = http.StatusOK
	res.Pesan = "Berhasil Get All Comment"
	res.Data = arrComments

	return res, nil
}
