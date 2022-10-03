package controllers

import (
	"fmt"
	"mova/models"
	"net/http"
	"strconv"

	"github.com/labstack/echo/v4"
)

func GetAllFavorites(c echo.Context) error {
	claim := getNilaiToken(c)
	user_id := fmt.Sprintf("%d", claim.Id)
	res, err := models.GetAllFavorites(user_id)

	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"Message": err.Error(),
		})
	}

	return c.JSON(http.StatusOK, res)
}

func GetAllFavoritesFilter(c echo.Context) error {
	claim := getNilaiToken(c)
	user_id := fmt.Sprintf("%d", claim.Id)
	category := c.QueryParam("category")

	res, err := models.GetAllFavoritesFilter(user_id, category)

	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"Message": err.Error(),
		})
	}

	return c.JSON(http.StatusOK, res)
}

func AddFavorite(c echo.Context) error {
	film_id, err := strconv.Atoi(c.FormValue("film_id"))
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"Message": err.Error(),
		})
	}

	claim := getNilaiToken(c)
	user_id := claim.Id

	thumbnail := c.FormValue("thumbnail")
	title := c.FormValue("title")

	rating, err := strconv.ParseFloat(c.FormValue("rating"), 32)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"Message": err.Error(),
		})
	}

	category := c.FormValue("category")
	createdAt := c.FormValue("createdAt")
	tipe := c.FormValue("tipe")
	user_uid := claim.Uid

	res, err := models.AddFavorite(film_id, user_id, thumbnail, title, float32(rating), category, createdAt, tipe, user_uid)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"Message": err.Error(),
		})
	}

	return c.JSON(http.StatusOK, res)
}

func DeleteFavorite(c echo.Context) error {
	id := c.Param("id")

	res, err := models.DeleteFavorite(id)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"Message": err.Error(),
		})
	}

	return c.JSON(http.StatusOK, res)
}
