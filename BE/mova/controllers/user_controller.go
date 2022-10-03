package controllers

import (
	"fmt"
	"mova/models"
	"net/http"

	"github.com/labstack/echo/v4"
)

func GenerateNewToken(c echo.Context) error {
	email := c.FormValue("email")
	uid := c.FormValue("uid")

	token, status, err := models.GenerateNewToken(email, uid)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"Message": err.Error(),
		})
	}

	if !status {
		return echo.ErrUnauthorized
	}

	return c.JSON(http.StatusOK, token)
}

func GetUser(c echo.Context) error {
	claim := getNilaiToken(c)
	id := fmt.Sprintf("%d", claim.Id)
	res, err := models.GetUser(id)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"Message": err.Error(),
		})
	}

	return c.JSON(http.StatusOK, res)
}

func EditProfileWithPicture(c echo.Context) error {
	claim := getNilaiToken(c)
	id := fmt.Sprintf("%d", claim.Id)
	picture, err := c.FormFile("picture")
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"Message": err.Error(),
		})
	}
	username := c.FormValue("username")

	res, err := models.EditProfileWithPicture(id, picture, username)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"Message": err.Error(),
		})
	}

	return c.JSON(http.StatusOK, res)
}

func EditProfileWithoutPicture(c echo.Context) error {
	claim := getNilaiToken(c)
	id := fmt.Sprintf("%d", claim.Id)
	username := c.FormValue("username")

	res, err := models.EditProfileWithoutPicture(id, username)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"Message": err.Error(),
		})
	}

	return c.JSON(http.StatusOK, res)
}
