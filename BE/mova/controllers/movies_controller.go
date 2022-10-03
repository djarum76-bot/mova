package controllers

import (
	"mova/models"
	"net/http"
	"strconv"

	"github.com/labstack/echo/v4"
)

func AddMovie(c echo.Context) error {
	thumbnail, err := c.FormFile("thumbnail")
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"Message": err.Error(),
		})
	}
	title := c.FormValue("title")
	rating, err := strconv.ParseFloat(c.FormValue("rating"), 32)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"Message": err.Error(),
		})
	}
	category := c.FormValue("category")
	form, err := c.MultipartForm()
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"Message": err.Error(),
		})
	}
	genre := form.Value["genre"]
	description := c.FormValue("description")
	video, err := c.FormFile("video")
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"Message": err.Error(),
		})
	}
	release := c.FormValue("release")
	region := c.FormValue("region")
	createdAt := c.FormValue("createdAt")

	res, err := models.AddMovie(thumbnail, title, float32(rating), category, genre, description, video, release, region, createdAt)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"Message": err.Error(),
		})
	}

	return c.JSON(http.StatusOK, res)
}

func Top10Movie(c echo.Context) error {
	res, err := models.Top10Movie()
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"Message": err.Error(),
		})
	}

	return c.JSON(http.StatusOK, res)
}

func GetMovie(c echo.Context) error {
	film_id := c.Param("film_id")
	res, err := models.GetMovie(film_id)

	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"Message": err.Error(),
		})
	}

	return c.JSON(http.StatusOK, res)
}
