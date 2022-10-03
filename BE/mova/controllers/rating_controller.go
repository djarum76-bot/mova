package controllers

import (
	"mova/models"
	"net/http"
	"strconv"

	"github.com/labstack/echo/v4"
)

func AddRating(c echo.Context) error {
	film_id, err := strconv.Atoi(c.FormValue("film_id"))
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"Message": err.Error(),
		})
	}

	claim := getNilaiToken(c)
	user_id := claim.Id
	user_uid := claim.Uid

	ratingFloat, err := strconv.ParseFloat(c.FormValue("rating"), 32)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"Message": err.Error(),
		})
	}

	createdAt := c.FormValue("createdAt")

	res, err := models.AddRating(film_id, user_id, user_uid, float32(ratingFloat), createdAt)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"Message": err.Error(),
		})
	}

	return c.JSON(http.StatusOK, res)
}
