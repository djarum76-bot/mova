package controllers

import (
	"mova/models"
	"net/http"
	"strconv"

	"github.com/labstack/echo/v4"
)

func ChargeTransaction(c echo.Context) error {
	claims := getNilaiToken(c)

	username := claims.Username
	email := claims.Email
	phone := claims.Phone
	id := c.FormValue("id")
	price, err := strconv.Atoi(c.FormValue("price"))
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"message": err.Error(),
		})
	}
	name := c.FormValue("name")

	res := models.ChargeTransaction(username, email, phone, id, price, name)

	return c.JSON(http.StatusOK, res)
}

func StatusTransaction(c echo.Context) error {
	transactionID := c.FormValue("transactionID")

	res, err := models.StatusTransaction(transactionID)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"message": err.Error(),
		})
	}

	return c.JSON(http.StatusOK, res)
}
