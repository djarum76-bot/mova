package models

import (
	"mova/db"
	"net/http"
)

func AddRating(film_id int, user_id int, user_uid string, ratingFloat float32, createdAt string) (Response, error) {
	var rating Rating
	var res Response
	var err error
	var id int

	con := db.CreateCon()

	sqlStatement := "INSERT INTO rating (film_id, user_id, user_uid, rating, createdAt) VALUES ($1, $2, $3, $4, $5) RETURNING id"

	err = con.QueryRow(sqlStatement, film_id, user_id, user_uid, ratingFloat, createdAt).Scan(&id)
	if err != nil {
		return res, err
	}

	rating.Id = id
	rating.FilmId = film_id
	rating.UserId = user_id
	rating.UserUID = user_uid
	rating.Rating = ratingFloat
	rating.CreatedAt = createdAt

	res.Status = http.StatusOK
	res.Pesan = "Berhasil Add Rating"
	res.Data = rating

	return res, nil
}
