package controllers

import (
	"mova/models"
	"net/http"
	"strings"

	"github.com/labstack/echo/v4"
)

func Top1(c echo.Context) error {
	res, err := models.Top1()
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"Message": err.Error(),
		})
	}

	return c.JSON(http.StatusOK, res)
}

func NewReleasesFilm(c echo.Context) error {
	res, err := models.NewReleasesFilm()

	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"Message": err.Error(),
		})
	}

	return c.JSON(http.StatusOK, res)
}

func TopSearch(c echo.Context) error {
	res, err := models.TopSearch()

	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"Message": err.Error(),
		})
	}

	return c.JSON(http.StatusOK, res)
}

func TopSearchFilter(c echo.Context) error {
	category := c.QueryParam("category")
	region := c.QueryParam("region")
	genre := c.QueryParam("genre")
	release := c.QueryParam("release")

	arrGenre := []string{genre}

	res, err := models.TopSearchFilter(category, region, arrGenre, release)

	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"Message": err.Error(),
		})
	}

	return c.JSON(http.StatusOK, res)
}

func Explore(c echo.Context) error {
	res, err := models.Explore()

	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"Message": err.Error(),
		})
	}

	return c.JSON(http.StatusOK, res)
}

func ExploreFilter(c echo.Context) error {
	category := c.QueryParam("category")
	region := c.QueryParam("region")
	genre := c.QueryParam("genre")
	release := c.QueryParam("release")

	arrGenre := []string{genre}

	res, err := models.ExploreFilter(category, region, arrGenre, release)

	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"Message": err.Error(),
		})
	}

	return c.JSON(http.StatusOK, res)
}

func ExploreSearch(c echo.Context) error {
	title := strings.ToLower(c.Param("title"))
	res, err := models.ExploreSearch(title)

	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"Message": err.Error(),
		})
	}

	return c.JSON(http.StatusOK, res)
}

func ExploreSearchFilter(c echo.Context) error {
	title := strings.ToLower(c.Param("title"))
	category := c.QueryParam("category")
	region := c.QueryParam("region")
	genre := c.QueryParam("genre")
	release := c.QueryParam("release")

	arrGenre := []string{genre}

	res, err := models.ExploreSearchFilter(title, category, region, arrGenre, release)

	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"Message": err.Error(),
		})
	}

	return c.JSON(http.StatusOK, res)
}

func Test(c echo.Context) error {
	name := c.QueryParam("name")
	umur := c.QueryParam("umur")
	return c.JSON(http.StatusOK, map[string]string{
		"name": name,
		"umur": umur,
	})
}
