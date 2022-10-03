package controllers

import (
	"mova/helper"
	"mova/models"
	"net/http"

	"github.com/labstack/echo/v4"
)

func RegisterPasswordWithPicture(c echo.Context) error {
	uid := c.FormValue("uid")
	username := c.FormValue("username")
	email := c.FormValue("email")
	phone := c.FormValue("phone")
	keyName := c.FormValue("keyName")
	picture, err := c.FormFile("picture")
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"Message": err.Error(),
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
	password, err := helper.HashPassword(c.FormValue("password"))
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"Message": err.Error(),
		})
	}

	res, status, err := models.RegisterPasswordWithPicture(uid, username, email, phone, keyName, picture, createdAt, pin, interest, password)
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

func RegisterPasswordWithoutPicture(c echo.Context) error {
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
	password, err := helper.HashPassword(c.FormValue("password"))
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"Message": err.Error(),
		})
	}

	res, status, err := models.RegisterPasswordWithoutPicture(uid, username, email, phone, keyName, createdAt, pin, interest, password)
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

func LoginPassword(c echo.Context) error {
	email := c.FormValue("email")
	password := c.FormValue("password")

	res, status, err := models.LoginPassword(email, password)
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
