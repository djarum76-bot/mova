package controllers

import (
	"mova/models"
	"net/http"
	"strconv"

	"github.com/labstack/echo/v4"
)

func AddSeries(c echo.Context) error {
	thumbnail, err := c.FormFile("thumbnail")
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"message": err.Error(),
		})
	}

	title := c.FormValue("title")

	rating, err := strconv.ParseFloat(c.FormValue("rating"), 32)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"message": err.Error(),
		})
	}

	category := c.FormValue("category")

	form1, err := c.MultipartForm()
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"message": err.Error(),
		})
	}
	genre := form1.Value["genre"]

	description := c.FormValue("description")

	form2, err := c.MultipartForm()
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"message": err.Error(),
		})
	}
	episode := form2.File["episode"]

	release := c.FormValue("release")
	region := c.FormValue("region")
	createdAt := c.FormValue("createdAt")

	res, err := models.AddSeries(thumbnail, title, float32(rating), category, genre, description, episode, release, region, createdAt)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"message": err.Error(),
		})
	}

	return c.JSON(http.StatusOK, res)
}

func GetSeries(c echo.Context) error {
	film_id := c.Param("film_id")
	res, err := models.GetSeries(film_id)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"message": err.Error(),
		})
	}

	return c.JSON(http.StatusOK, res)
}
