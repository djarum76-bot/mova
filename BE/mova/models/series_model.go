package models

import (
	"io"
	"mime/multipart"
	"mova/db"
	"net/http"
	"os"

	"github.com/lib/pq"
)

func AddSeries(thumbnail *multipart.FileHeader, title string, rating float32, category string, genre []string, description string, episode []*multipart.FileHeader, release string, region string, createdAt string) (Response, error) {
	var series Series
	var film Film
	var res Response
	var err error
	var series_id int
	var film_id int
	var arrEpisodeUrl []string

	con := db.CreateCon()

	sqlStatement1 := "INSERT INTO film (thumbnail, title, rating, category, genre, release, region, createdAt, tipe, url) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10) RETURNING id"
	sqlStatement2 := "INSERT INTO series (film_id, thumbnail, title, rating, category, genre, description, episode, release, region, createdAt) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11) RETURNING id"

	//thumbnail
	src, err := thumbnail.Open()
	if err != nil {
		return res, err
	}
	defer src.Close()

	thumbnailUrl := "thumbnail/" + thumbnail.Filename

	dst, err := os.Create(thumbnailUrl)
	if err != nil {
		return res, err
	}
	defer dst.Close()

	if _, err = io.Copy(dst, src); err != nil {
		return res, err
	}

	//episode
	for _, eps := range episode {
		//source
		src, err := eps.Open()
		if err != nil {
			return res, err
		}
		defer src.Close()

		epsUrl := "series/" + eps.Filename

		//destinanion
		dst, err := os.Create(epsUrl)
		if err != nil {
			return res, err
		}
		defer dst.Close()

		//copy
		if _, err = io.Copy(dst, src); err != nil {
			return res, err
		}

		arrEpisodeUrl = append(arrEpisodeUrl, epsUrl)
	}

	err = con.QueryRow(sqlStatement1, thumbnailUrl, title, rating, category, pq.Array(genre), release, region, createdAt, "series", arrEpisodeUrl[0]).Scan(&film_id)
	if err != nil {
		return res, err
	}

	film.Id = film_id
	film.Thumbnail = thumbnailUrl
	film.Title = title
	film.Rating = rating
	film.Category = category
	film.Genre = genre
	film.Release = release
	film.Region = region
	film.CreatedAt = createdAt
	film.Tipe = "series"
	film.Url = arrEpisodeUrl[0]

	err = con.QueryRow(sqlStatement2, film.Id, thumbnailUrl, title, rating, category, pq.Array(genre), description, pq.Array(arrEpisodeUrl), release, region, createdAt).Scan(&series_id)
	if err != nil {
		return res, err
	}

	series.Id = series_id
	series.FilmID = film.Id
	series.Thumbnail = thumbnailUrl
	series.Title = title
	series.Rating = rating
	series.Category = category
	series.Genre = genre
	series.Description = description
	series.Episode = arrEpisodeUrl
	series.Release = release
	series.Region = region
	series.CreatedAt = createdAt

	res.Status = http.StatusOK
	res.Pesan = "Berhasil Add Series"
	res.Data = map[string]interface{}{
		"film":   film,
		"series": series,
	}

	return res, nil
}

func GetSeries(film_id string) (Response, error) {
	var userFavorite UserFavorite
	arrUserFavorite := []UserFavorite{}
	var rating float32
	var res Response
	var err error
	var series Series

	con := db.CreateCon()

	sqlStatement1 := "SELECT * FROM series WHERE film_id = ($1)"
	sqlStatement2 := "SELECT id, film_id, user_id, user_uid FROM favorite WHERE film_id = ($1)"
	sqlStatement3 := "SELECT AVG(rating) FROM rating WHERE film_id = ($1)"

	err = con.QueryRow(sqlStatement1, film_id).Scan(&series.Id, &series.FilmID, &series.Thumbnail, &series.Title, &series.Rating, &series.Category, pq.Array(&series.Genre), &series.Description, pq.Array(&series.Episode), &series.Release, &series.Region, &series.CreatedAt)
	if err != nil {
		return res, err
	}

	rowsFavorite, err := con.Query(sqlStatement2, film_id)
	if err != nil {
		return res, err
	}
	defer rowsFavorite.Close()

	for rowsFavorite.Next() {
		err = rowsFavorite.Scan(&userFavorite.Id, &userFavorite.FilmId, &userFavorite.UserId, &userFavorite.UserUID)
		if err != nil {
			return res, err
		}

		arrUserFavorite = append(arrUserFavorite, userFavorite)
	}
	series.UserFavorites = arrUserFavorite

	err = con.QueryRow(sqlStatement3, film_id).Scan(&rating)
	if err != nil {
		return res, err
	}
	series.Rating = rating

	res.Status = http.StatusOK
	res.Pesan = "Berhasil Get All Series"
	res.Data = series

	return res, nil
}
