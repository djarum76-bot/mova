package controllers

import (
	"mova/models"
	"net/http"
	"strconv"

	"github.com/labstack/echo/v4"
)

func AddComment(c echo.Context) error {
	film_id, err := strconv.Atoi(c.FormValue("film_id"))
	if err != nil {
		c.JSON(http.StatusInternalServerError, map[string]string{
			"Message": err.Error(),
		})
	}

	claims := getNilaiToken(c)
	user_id := claims.Id
	user_uid := claims.Uid
	username := claims.Username
	picture := claims.Picture
	comment := c.FormValue("comment")
	createdAt := c.FormValue("createdAt")

	res, err := models.AddComment(film_id, user_id, user_uid, username, picture, comment, createdAt)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"Message": err.Error(),
		})
	}
	return c.JSON(http.StatusOK, res)
}

func GetAllComment(c echo.Context) error {
	film_id := c.Param("film_id")

	res, err := models.GetAllComment(film_id)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"Message": err.Error(),
		})
	}

	return c.JSON(http.StatusOK, res)
}
