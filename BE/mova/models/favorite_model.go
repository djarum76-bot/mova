package models

import (
	"mova/db"
	"net/http"
)

func GetAllFavorites(user_id string) (Response, error) {
	var favorite Favorite
	arrFavorite := []Favorite{}
	var rating float32
	var res Response
	var err error

	con := db.CreateCon()

	sqlStatement1 := "SELECT * FROM favorite WHERE user_id = ($1) ORDER BY createdAt"
	sqlStatement2 := "SELECT AVG(rating) FROM rating WHERE film_id = ($1)"

	rows, err := con.Query(sqlStatement1, user_id)
	if err != nil {
		return res, err
	}
	defer rows.Close()

	for rows.Next() {
		err = rows.Scan(&favorite.Id, &favorite.FilmId, &favorite.UserId, &favorite.Thumbnail, &favorite.Title, &favorite.Rating, &favorite.Category, &favorite.CreatedAt, &favorite.Tipe, &favorite.UserUID)
		if err != nil {
			return res, err
		}

		err = con.QueryRow(sqlStatement2, favorite.FilmId).Scan(&rating)
		if err != nil {
			return res, err
		}
		favorite.Rating = rating

		arrFavorite = append(arrFavorite, favorite)
	}

	res.Status = http.StatusOK
	res.Pesan = "Berhasil Get All Favorite"
	res.Data = arrFavorite

	return res, nil
}

func GetAllFavoritesFilter(user_id string, category string) (Response, error) {
	var favorite Favorite
	arrFavorite := []Favorite{}
	var rating float32
	var res Response
	var err error

	con := db.CreateCon()

	sqlStatement1 := "SELECT * FROM favorite WHERE user_id = ($1) AND category = ($2) ORDER BY createdAt"
	sqlStatement2 := "SELECT AVG(rating) FROM rating WHERE film_id = ($1)"

	rows, err := con.Query(sqlStatement1, user_id, category)
	if err != nil {
		return res, err
	}
	defer rows.Close()

	for rows.Next() {
		err = rows.Scan(&favorite.Id, &favorite.FilmId, &favorite.UserId, &favorite.Thumbnail, &favorite.Title, &favorite.Rating, &favorite.Category, &favorite.CreatedAt, &favorite.Tipe, &favorite.UserUID)
		if err != nil {
			return res, err
		}

		err = con.QueryRow(sqlStatement2, favorite.FilmId).Scan(&rating)
		if err != nil {
			return res, err
		}
		favorite.Rating = rating

		arrFavorite = append(arrFavorite, favorite)
	}

	res.Status = http.StatusOK
	res.Pesan = "Berhasil Get All Favorite Filter"
	res.Data = arrFavorite

	return res, nil
}

func AddFavorite(film_id int, user_id int, thumbnail string, title string, rating float32, category string, createdAt string, tipe string, user_uid string) (Response, error) {
	var favorite Favorite
	var res Response
	var err error
	var id int

	con := db.CreateCon()

	sqlStatement := "INSERT INTO favorite (film_id, user_id, thumbnail, title, rating, category, createdAt, tipe, user_uid) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9) RETURNING id"

	err = con.QueryRow(sqlStatement, film_id, user_id, thumbnail, title, rating, category, createdAt, tipe, user_uid).Scan(&id)
	if err != nil {
		return res, err
	}

	favorite.Id = id
	favorite.FilmId = film_id
	favorite.UserId = user_id
	favorite.Thumbnail = thumbnail
	favorite.Title = title
	favorite.Rating = rating
	favorite.Category = category
	favorite.CreatedAt = createdAt
	favorite.Tipe = tipe
	favorite.UserUID = user_uid

	res.Status = http.StatusOK
	res.Pesan = "Berhasil Add Favorite"
	res.Data = favorite

	return res, nil
}

func DeleteFavorite(id string) (Response, error) {
	var res Response
	var err error

	con := db.CreateCon()

	sqlStatement := "DELETE FROM favorite WHERE id = ($1)"

	_, err = con.Exec(sqlStatement, id)
	if err != nil {
		return res, err
	}

	res.Status = http.StatusOK
	res.Pesan = "Berhasil Delete Favorite"
	res.Data = "Berhasil Delete Favorite"

	return res, nil
}
