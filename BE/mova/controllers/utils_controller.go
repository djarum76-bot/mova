package controllers

import (
	"mova/models"
	"net/http"

	"github.com/labstack/echo/v4"
)

func CheckUsernamePhone(c echo.Context) error {
	username := c.FormValue("username")
	phone := c.FormValue("phone")

	status := models.CheckUsernamePhone(username, phone)
	if status == http.StatusOK {
		return c.JSON(http.StatusOK, map[string]string{
			"Message": "Available",
		})
	} else {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"Message": "Not Available",
		})
	}
}

func CheckEmail(c echo.Context) error {
	email := c.FormValue("email")

	status := models.CheckEmail(email)
	if status == http.StatusOK {
		return c.JSON(http.StatusOK, map[string]string{
			"Message": "Available",
		})
	} else {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"Message": "Not Available",
		})
	}

}
