package controllers

import (
	"mova/models"
	"net/http"

	"github.com/labstack/echo/v4"
)

func RegisterGoogleWithPicture(c echo.Context) error {
	uid := c.FormValue("uid")
	username := c.FormValue("username")
	email := c.FormValue("email")
	phone := c.FormValue("phone")
	keyName := c.FormValue("keyName")
	picture, err := c.FormFile("picture")
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"Message": err.Error(),
			"sector":  "1",
		})
	}
	createdAt := c.FormValue("createdAt")
	pin := c.FormValue("pin")
	form, err := c.MultipartForm()
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"Message": err.Error(),
		})
	}
	interest := form.Value["interest"]

	res, status, err := models.RegisterGoogleWithPicture(uid, username, email, phone, keyName, picture, createdAt, pin, interest)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"Message": err.Error(),
		})
	}

	if !status {
		return echo.ErrUnauthorized
	}

	return c.JSON(http.StatusOK, res)
}

func RegisterGoogleWithoutPicture(c echo.Context) error {
	uid := c.FormValue("uid")
	username := c.FormValue("username")
	email := c.FormValue("email")
	phone := c.FormValue("phone")
	keyName := c.FormValue("keyName")
	createdAt := c.FormValue("createdAt")
	pin := c.FormValue("pin")
	form, err := c.MultipartForm()
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"Message": err.Error(),
		})
	}
	interest := form.Value["interest"]

	res, status, err := models.RegisterGoogleWithoutPicture(uid, username, email, phone, keyName, createdAt, pin, interest)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"Message": err.Error(),
		})
	}

	if !status {
		return echo.ErrUnauthorized
	}

	return c.JSON(http.StatusOK, res)
}

func LoginGoogle(c echo.Context) error {
	email := c.FormValue("email")

	res, status, err := models.LoginGoogle(email)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"Message": err.Error(),
		})
	}

	if !status {
		return echo.ErrUnauthorized
	}

	return c.JSON(http.StatusOK, res)
}
