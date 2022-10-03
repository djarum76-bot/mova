package models

import (
	"io"
	"mime/multipart"
	"mova/db"
	"net/http"
	"os"

	"github.com/lib/pq"
)

func AddMovie(thumbnail *multipart.FileHeader, title string, rating float32, category string, genre []string, description string, video *multipart.FileHeader, release string, region string, createdAt string) (Response, error) {
	var movie Movie
	var film Film
	var err error
	var res Response
	var movie_id int
	var film_id int

	con := db.CreateCon()

	sqlStatement1 := "INSERT INTO film (thumbnail, title, rating, category, genre, release, region, createdAt, tipe, url) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10) RETURNING id"
	sqlStatement2 := "INSERT INTO movies (film_id, thumbnail, title, rating, category, genre, description, url, release, region, createdAt) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11) RETURNING id"

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

	//url
	src, err = video.Open()
	if err != nil {
		return res, err
	}
	defer src.Close()

	movieUrl := "movies/" + video.Filename

	dst, err = os.Create(movieUrl)
	if err != nil {
		return res, err
	}
	defer dst.Close()

	if _, err = io.Copy(dst, src); err != nil {
		return res, err
	}

	err = con.QueryRow(sqlStatement1, thumbnailUrl, title, rating, category, pq.Array(genre), release, region, createdAt, "movie", movieUrl).Scan(&film_id)
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
	film.Tipe = "movie"
	film.Url = movieUrl

	err = con.QueryRow(sqlStatement2, film.Id, thumbnailUrl, title, rating, category, pq.Array(genre), description, movieUrl, release, region, createdAt).Scan(&movie_id)
	if err != nil {
		return res, err
	}

	movie.Id = movie_id
	movie.FilmID = film.Id
	movie.Thumbnail = thumbnailUrl
	movie.Title = title
	movie.Rating = rating
	movie.Category = category
	movie.Genre = genre
	movie.Description = description
	movie.Url = movieUrl
	movie.Release = release
	movie.Region = region
	movie.CreatedAt = createdAt

	res.Status = http.StatusOK
	res.Pesan = "Berhasil Add Movie"
	res.Data = map[string]interface{}{
		"film":  film,
		"movie": movie,
	}

	return res, nil
}

func Top10Movie() (Response, error) {
	var movie Movie
	arrMovie := []Movie{}
	arrUserFavorite := []UserFavorite{}
	arrUserComment := []Comments{}
	var rating float32
	var res Response
	var err error

	con := db.CreateCon()

	sqlStatement1 := "SELECT * FROM movies ORDER BY rating DESC LIMIT 10"
	sqlStatement2 := "SELECT AVG(rating) FROM rating WHERE film_id = ($1)"

	rows, err := con.Query(sqlStatement1)
	if err != nil {
		return res, err
	}
	defer rows.Close()

	for rows.Next() {
		err = rows.Scan(&movie.Id, &movie.FilmID, &movie.Thumbnail, &movie.Title, &movie.Rating, &movie.Category, pq.Array(&movie.Genre), &movie.Description, &movie.Url, &movie.Release, &movie.Region, &movie.CreatedAt)
		if err != nil {
			return res, err
		}

		movie.UserFavorites = arrUserFavorite
		movie.UserComments = arrUserComment

		//rating
		err = con.QueryRow(sqlStatement2, movie.FilmID).Scan(&rating)
		if err != nil {
			return res, err
		}
		movie.Rating = rating

		arrMovie = append(arrMovie, movie)
	}

	res.Status = http.StatusOK
	res.Pesan = "Berhasil Get Data"
	res.Data = arrMovie

	return res, nil
}

func GetMovie(film_id string) (Response, error) {
	var userFavorite UserFavorite
	arrUserFavorite := []UserFavorite{}
	var userComment Comments
	arrUserComment := []Comments{}
	var rating float32
	var res Response
	var err error
	var movie Movie

	con := db.CreateCon()

	sqlStatement1 := "SELECT * FROM movies WHERE film_id = ($1)"
	sqlStatement2 := "SELECT id, film_id, user_id, user_uid FROM favorite WHERE film_id = ($1)"
	sqlStatement3 := "SELECT * FROM comments WHERE film_id = ($1) ORDER BY createdAt DESC"
	sqlStatement4 := "SELECT AVG(rating) FROM rating WHERE film_id = ($1)"

	err = con.QueryRow(sqlStatement1, film_id).Scan(&movie.Id, &movie.FilmID, &movie.Thumbnail, &movie.Title, &movie.Rating, &movie.Category, pq.Array(&movie.Genre), &movie.Description, &movie.Url, &movie.Release, &movie.Region, &movie.CreatedAt)
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
	movie.UserFavorites = arrUserFavorite

	rowsComment, err := con.Query(sqlStatement3, film_id)
	if err != nil {
		return res, err
	}
	defer rowsComment.Close()

	for rowsComment.Next() {
		err = rowsComment.Scan(&userComment.Id, &userComment.FilmId, &userComment.UserId, &userComment.UserUID, &userComment.Username, &userComment.Picture, &userComment.Comment, &userComment.CreatedAt)
		if err != nil {
			return res, err
		}

		arrUserComment = append(arrUserComment, userComment)
	}
	movie.UserComments = arrUserComment

	err = con.QueryRow(sqlStatement4, movie.FilmID).Scan(&rating)
	if err != nil {
		return res, err
	}
	movie.Rating = rating

	res.Status = http.StatusOK
	res.Pesan = "Berhasil Get Data"
	res.Data = movie

	return res, nil
}
