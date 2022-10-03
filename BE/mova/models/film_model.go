package models

import (
	"mova/db"
	"net/http"
	"strings"

	"github.com/lib/pq"
)

func Top1() (Response, error) {
	var userFavorite UserFavorite
	arrUserFavorite := []UserFavorite{}
	var filmUserFavorite FilmUserFavorite
	var rating float32
	var res Response
	var err error

	con := db.CreateCon()

	sqlStatement1 := "SELECT * FROM film ORDER BY rating DESC LIMIT 1"
	sqlStatement2 := "SELECT id, film_id, user_id, user_uid FROM favorite WHERE film_id = ($1)"
	sqlStatement3 := "SELECT AVG(rating) FROM rating WHERE film_id = ($1)"

	err = con.QueryRow(sqlStatement1).Scan(&filmUserFavorite.Id, &filmUserFavorite.Thumbnail, &filmUserFavorite.Title, &filmUserFavorite.Rating, &filmUserFavorite.Category, pq.Array(&filmUserFavorite.Genre), &filmUserFavorite.Release, &filmUserFavorite.Region, &filmUserFavorite.CreatedAt, &filmUserFavorite.Tipe, &filmUserFavorite.Url)
	if err != nil {
		return res, err
	}

	rows, err := con.Query(sqlStatement2, filmUserFavorite.Id)
	if err != nil {
		return res, err
	}
	defer rows.Close()

	for rows.Next() {
		err = rows.Scan(&userFavorite.Id, &userFavorite.FilmId, &userFavorite.UserId, &userFavorite.UserUID)
		if err != nil {
			return res, err
		}

		arrUserFavorite = append(arrUserFavorite, userFavorite)
	}
	filmUserFavorite.UserFavorites = arrUserFavorite

	err = con.QueryRow(sqlStatement3, filmUserFavorite.Id).Scan(&rating)
	if err != nil {
		return res, err
	}
	filmUserFavorite.Rating = rating

	res.Status = http.StatusOK
	res.Pesan = "Berhasil Get Data"
	res.Data = filmUserFavorite

	return res, nil
}

func NewReleasesFilm() (Response, error) {
	var film Film
	arrFilm := []Film{}
	var rating float32
	var res Response
	var err error

	con := db.CreateCon()

	sqlStatement1 := "SELECT * FROM film ORDER BY createdAt DESC LIMIT 10"
	sqlStatement2 := "SELECT AVG(rating) FROM rating WHERE film_id = ($1)"

	rows, err := con.Query(sqlStatement1)
	if err != nil {
		return res, err
	}
	defer rows.Close()

	for rows.Next() {
		err = rows.Scan(&film.Id, &film.Thumbnail, &film.Title, &film.Rating, &film.Category, pq.Array(&film.Genre), &film.Release, &film.Region, &film.CreatedAt, &film.Tipe, &film.Url)
		if err != nil {
			return res, err
		}

		err = con.QueryRow(sqlStatement2, film.Id).Scan(&rating)
		if err != nil {
			return res, err
		}
		film.Rating = rating

		arrFilm = append(arrFilm, film)
	}

	res.Status = http.StatusOK
	res.Pesan = "Berhasil Get Film"
	res.Data = arrFilm

	return res, nil
}

func TopSearch() (Response, error) {
	var film Film
	arrFilm := []Film{}
	var rating float32
	var res Response
	var err error

	con := db.CreateCon()

	sqlStatement1 := "SELECT * FROM film ORDER BY createdAt DESC LIMIT 10"
	sqlStatement2 := "SELECT AVG(rating) FROM rating WHERE film_id = ($1)"

	rows, err := con.Query(sqlStatement1)
	if err != nil {
		return res, err
	}
	defer rows.Close()

	for rows.Next() {
		err = rows.Scan(&film.Id, &film.Thumbnail, &film.Title, &film.Rating, &film.Category, pq.Array(&film.Genre), &film.Release, &film.Region, &film.CreatedAt, &film.Tipe, &film.Url)
		if err != nil {
			return res, err
		}

		err = con.QueryRow(sqlStatement2, film.Id).Scan(&rating)
		if err != nil {
			return res, err
		}
		film.Rating = rating

		arrFilm = append(arrFilm, film)
	}

	res.Status = http.StatusOK
	res.Pesan = "Berhasil Get Film"
	res.Data = arrFilm

	return res, nil
}

func TopSearchFilter(category string, region string, genre []string, release string) (Response, error) {
	var film Film
	arrFilm := []Film{}
	var rating float32
	var res Response

	con := db.CreateCon()

	sqlStatement1 := "SELECT * FROM film "
	sqlStatement2 := "SELECT AVG(rating) FROM rating WHERE film_id = ($1)"

	if category != "" {
		if strings.Contains(sqlStatement1, "WHERE") {
			sqlStatement1 += "AND category = " + "'" + category + "' "
		} else {
			sqlStatement1 += "WHERE category = " + "'" + category + "' "
		}
	}

	if region != "" {
		if strings.Contains(sqlStatement1, "WHERE") {
			sqlStatement1 += "AND region = " + "'" + region + "' "
		} else {
			sqlStatement1 += "WHERE region = " + "'" + region + "' "
		}
	}

	if genre[0] != "" {
		if strings.Contains(sqlStatement1, "WHERE") {
			sqlStatement1 += "AND $1 <@ genre "
		} else {
			sqlStatement1 += "WHERE $1 <@ genre "
		}
	}

	if release != "" {
		if strings.Contains(sqlStatement1, "WHERE") {
			sqlStatement1 += "AND release = " + "'" + release + "' "
		} else {
			sqlStatement1 += "WHERE release = " + "'" + release + "' "
		}
	}

	sqlStatement1 += "ORDER BY createdAt DESC LIMIT 10"

	if genre[0] != "" {
		rows, err := con.Query(sqlStatement1, pq.Array(genre))
		if err != nil {
			return res, err
		}
		defer rows.Close()

		for rows.Next() {
			err = rows.Scan(&film.Id, &film.Thumbnail, &film.Title, &film.Rating, &film.Category, pq.Array(&film.Genre), &film.Release, &film.Region, &film.CreatedAt, &film.Tipe, &film.Url)
			if err != nil {
				return res, err
			}

			err = con.QueryRow(sqlStatement2, film.Id).Scan(&rating)
			if err != nil {
				return res, err
			}
			film.Rating = rating

			arrFilm = append(arrFilm, film)
		}
	} else {
		rows, err := con.Query(sqlStatement1)
		if err != nil {
			return res, err
		}
		defer rows.Close()

		for rows.Next() {
			err = rows.Scan(&film.Id, &film.Thumbnail, &film.Title, &film.Rating, &film.Category, pq.Array(&film.Genre), &film.Release, &film.Region, &film.CreatedAt, &film.Tipe, &film.Url)
			if err != nil {
				return res, err
			}

			err = con.QueryRow(sqlStatement2, film.Id).Scan(&rating)
			if err != nil {
				return res, err
			}
			film.Rating = rating

			arrFilm = append(arrFilm, film)
		}
	}

	res.Status = http.StatusOK
	res.Pesan = "Berhasil Get Film"
	res.Data = arrFilm

	return res, nil
}

func Explore() (Response, error) {
	var film Film
	arrFilm := []Film{}
	var rating float32
	var res Response
	var err error

	con := db.CreateCon()

	sqlStatement1 := "SELECT * FROM film ORDER BY createdAt DESC"
	sqlStatement2 := "SELECT AVG(rating) FROM rating WHERE film_id = ($1)"

	rows, err := con.Query(sqlStatement1)
	if err != nil {
		return res, err
	}
	defer rows.Close()

	for rows.Next() {
		err = rows.Scan(&film.Id, &film.Thumbnail, &film.Title, &film.Rating, &film.Category, pq.Array(&film.Genre), &film.Release, &film.Region, &film.CreatedAt, &film.Tipe, &film.Url)
		if err != nil {
			return res, err
		}

		err = con.QueryRow(sqlStatement2, film.Id).Scan(&rating)
		if err != nil {
			return res, err
		}
		film.Rating = rating

		arrFilm = append(arrFilm, film)
	}

	res.Status = http.StatusOK
	res.Pesan = "Berhasil Get Film"
	res.Data = arrFilm

	return res, nil
}

func ExploreFilter(category string, region string, genre []string, release string) (Response, error) {
	var film Film
	arrFilm := []Film{}
	var rating float32
	var res Response

	con := db.CreateCon()

	sqlStatement1 := "SELECT * FROM film "
	sqlStatement2 := "SELECT AVG(rating) FROM rating WHERE film_id = ($1)"

	if category != "" {
		if strings.Contains(sqlStatement1, "WHERE") {
			sqlStatement1 += "AND category = " + "'" + category + "' "
		} else {
			sqlStatement1 += "WHERE category = " + "'" + category + "' "
		}
	}

	if region != "" {
		if strings.Contains(sqlStatement1, "WHERE") {
			sqlStatement1 += "AND region = " + "'" + region + "' "
		} else {
			sqlStatement1 += "WHERE region = " + "'" + region + "' "
		}
	}

	if genre[0] != "" {
		if strings.Contains(sqlStatement1, "WHERE") {
			sqlStatement1 += "AND $1 <@ genre "
		} else {
			sqlStatement1 += "WHERE $1 <@ genre "
		}
	}

	if release != "" {
		if strings.Contains(sqlStatement1, "WHERE") {
			sqlStatement1 += "AND release = " + "'" + release + "' "
		} else {
			sqlStatement1 += "WHERE release = " + "'" + release + "' "
		}
	}

	if genre[0] != "" {
		rows, err := con.Query(sqlStatement1, pq.Array(genre))
		if err != nil {
			return res, err
		}
		defer rows.Close()

		for rows.Next() {
			err = rows.Scan(&film.Id, &film.Thumbnail, &film.Title, &film.Rating, &film.Category, pq.Array(&film.Genre), &film.Release, &film.Region, &film.CreatedAt, &film.Tipe, &film.Url)
			if err != nil {
				return res, err
			}

			err = con.QueryRow(sqlStatement2, film.Id).Scan(&rating)
			if err != nil {
				return res, err
			}
			film.Rating = rating

			arrFilm = append(arrFilm, film)
		}
	} else {
		rows, err := con.Query(sqlStatement1)
		if err != nil {
			return res, err
		}
		defer rows.Close()

		for rows.Next() {
			err = rows.Scan(&film.Id, &film.Thumbnail, &film.Title, &film.Rating, &film.Category, pq.Array(&film.Genre), &film.Release, &film.Region, &film.CreatedAt, &film.Tipe, &film.Url)
			if err != nil {
				return res, err
			}

			err = con.QueryRow(sqlStatement2, film.Id).Scan(&rating)
			if err != nil {
				return res, err
			}
			film.Rating = rating

			arrFilm = append(arrFilm, film)
		}
	}

	res.Status = http.StatusOK
	res.Pesan = "Berhasil Get Film"
	res.Data = arrFilm

	return res, nil
}

func ExploreSearch(title string) (Response, error) {
	var film Film
	arrFilm := []Film{}
	var rating float32
	var res Response
	var err error

	con := db.CreateCon()

	sqlStatement1 := "SELECT * FROM film WHERE LOWER(film.title) LIKE " + "'%" + title + "%'"
	sqlStatement2 := "SELECT AVG(rating) FROM rating WHERE film_id = ($1)"

	rows, err := con.Query(sqlStatement1)
	if err != nil {
		return res, err
	}
	defer rows.Close()

	for rows.Next() {
		err = rows.Scan(&film.Id, &film.Thumbnail, &film.Title, &film.Rating, &film.Category, pq.Array(&film.Genre), &film.Release, &film.Region, &film.CreatedAt, &film.Tipe, &film.Url)
		if err != nil {
			return res, err
		}

		err = con.QueryRow(sqlStatement2, film.Id).Scan(&rating)
		if err != nil {
			return res, err
		}
		film.Rating = rating

		arrFilm = append(arrFilm, film)
	}

	res.Status = http.StatusOK
	res.Pesan = "Berhasil Get Film"
	res.Data = arrFilm

	return res, nil
}

func ExploreSearchFilter(title string, category string, region string, genre []string, release string) (Response, error) {
	var film Film
	arrFilm := []Film{}
	var rating float32
	var res Response

	con := db.CreateCon()

	sqlStatement1 := "SELECT * FROM film "
	sqlStatement2 := "SELECT AVG(rating) FROM rating WHERE film_id = ($1)"

	if category != "" {
		if strings.Contains(sqlStatement1, "WHERE") {
			sqlStatement1 += "AND category = " + "'" + category + "' "
		} else {
			sqlStatement1 += "WHERE category = " + "'" + category + "' "
		}
	}

	if region != "" {
		if strings.Contains(sqlStatement1, "WHERE") {
			sqlStatement1 += "AND region = " + "'" + region + "' "
		} else {
			sqlStatement1 += "WHERE region = " + "'" + region + "' "
		}
	}

	if genre[0] != "" {
		if strings.Contains(sqlStatement1, "WHERE") {
			sqlStatement1 += "AND $1 <@ genre "
		} else {
			sqlStatement1 += "WHERE $1 <@ genre "
		}
	}

	if release != "" {
		if strings.Contains(sqlStatement1, "WHERE") {
			sqlStatement1 += "AND release = " + "'" + release + "' "
		} else {
			sqlStatement1 += "WHERE release = " + "'" + release + "' "
		}
	}

	sqlStatement1 += "AND LOWER(film.title) LIKE " + "'%" + title + "%'"

	if genre[0] != "" {
		rows, err := con.Query(sqlStatement1, pq.Array(genre))
		if err != nil {
			return res, err
		}
		defer rows.Close()

		for rows.Next() {
			err = rows.Scan(&film.Id, &film.Thumbnail, &film.Title, &film.Rating, &film.Category, pq.Array(&film.Genre), &film.Release, &film.Region, &film.CreatedAt, &film.Tipe, &film.Url)
			if err != nil {
				return res, err
			}

			err = con.QueryRow(sqlStatement2, film.Id).Scan(&rating)
			if err != nil {
				return res, err
			}
			film.Rating = rating

			arrFilm = append(arrFilm, film)
		}
	} else {
		rows, err := con.Query(sqlStatement1)
		if err != nil {
			return res, err
		}
		defer rows.Close()

		for rows.Next() {
			err = rows.Scan(&film.Id, &film.Thumbnail, &film.Title, &film.Rating, &film.Category, pq.Array(&film.Genre), &film.Release, &film.Region, &film.CreatedAt, &film.Tipe, &film.Url)
			if err != nil {
				return res, err
			}

			err = con.QueryRow(sqlStatement2, film.Id).Scan(&rating)
			if err != nil {
				return res, err
			}
			film.Rating = rating

			arrFilm = append(arrFilm, film)
		}
	}

	res.Status = http.StatusOK
	res.Pesan = "Berhasil Get Film"
	res.Data = arrFilm

	return res, nil
}
