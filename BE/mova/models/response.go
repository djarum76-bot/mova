package models

import (
	"database/sql"

	"github.com/golang-jwt/jwt"
)

type ResponseToken struct {
	Status int         `json:"status"`
	Pesan  string      `json:"pesan"`
	Data   interface{} `json:"data"`
	Token  string      `json:"token"`
}

type Response struct {
	Status int         `json:"status"`
	Pesan  string      `json:"pesan"`
	Data   interface{} `json:"data"`
}

type User struct {
	Id        int            `json:"id"`
	Uid       string         `json:"uid"`
	Username  string         `json:"username"`
	Email     string         `json:"email"`
	Phone     string         `json:"phone"`
	KeyName   string         `json:"keyName"`
	Picture   sql.NullString `json:"picture"`
	CreatedAt string         `json:"createdAt"`
	Pin       string         `json:"pin"`
	Interest  []string       `json:"interest"`
}

type JwtCustomClaims struct {
	Id       int            `json:"id"`
	Uid      string         `json:"uid"`
	Username string         `json:"username"`
	Email    string         `json:"email"`
	Phone    string         `json:"phone"`
	Picture  sql.NullString `json:"picture"`
	jwt.StandardClaims
}

type Film struct {
	Id        int      `json:"id"`
	Thumbnail string   `json:"thumbnail"`
	Title     string   `json:"title"`
	Rating    float32  `json:"rating"`
	Category  string   `json:"category"`
	Genre     []string `json:"genre"`
	Release   string   `json:"release"`
	Region    string   `json:"region"`
	CreatedAt string   `json:"createdAt"`
	Tipe      string   `json:"tipe"`
	Url       string   `json:"url"`
}

type Movie struct {
	Id            int            `json:"id"`
	FilmID        int            `json:"film_id"`
	Thumbnail     string         `json:"thumbnail"`
	Title         string         `json:"title"`
	Rating        float32        `json:"rating"`
	Category      string         `json:"category"`
	Genre         []string       `json:"genre"`
	Description   string         `json:"description"`
	Url           string         `json:"url"`
	Release       string         `json:"release"`
	Region        string         `json:"region"`
	CreatedAt     string         `json:"createdAt"`
	UserFavorites []UserFavorite `json:"user_favorites"`
	UserComments  []Comments     `json:"user_comments"`
}

type Series struct {
	Id            int            `json:"id"`
	FilmID        int            `json:"film_id"`
	Thumbnail     string         `json:"thumbnail"`
	Title         string         `json:"title"`
	Rating        float32        `json:"rating"`
	Category      string         `json:"category"`
	Genre         []string       `json:"genre"`
	Description   string         `json:"description"`
	Episode       []string       `json:"episode"`
	Release       string         `json:"release"`
	Region        string         `json:"region"`
	CreatedAt     string         `json:"createdAt"`
	UserFavorites []UserFavorite `json:"user_favorites"`
}

type Rating struct {
	Id        int     `json:"id"`
	FilmId    int     `json:"film_id"`
	UserId    int     `json:"user_id"`
	UserUID   string  `json:"user_uid"`
	Rating    float32 `json:"rating"`
	CreatedAt string  `json:"createdAt"`
}

type Favorite struct {
	Id        int     `json:"id"`
	FilmId    int     `json:"film_id"`
	UserId    int     `json:"user_id"`
	Thumbnail string  `json:"thumbnail"`
	Title     string  `json:"title"`
	Rating    float32 `json:"rating"`
	Category  string  `json:"category"`
	CreatedAt string  `json:"createdAt"`
	Tipe      string  `json:"tipe"`
	UserUID   string  `json:"user_uid"`
}

type UserFavorite struct {
	Id      int    `json:"id"`
	FilmId  int    `json:"film_id"`
	UserId  int    `json:"user_id"`
	UserUID string `json:"user_uid"`
}

type FilmUserFavorite struct {
	Id            int            `json:"id"`
	Thumbnail     string         `json:"thumbnail"`
	Title         string         `json:"title"`
	Rating        float32        `json:"rating"`
	Category      string         `json:"category"`
	Genre         []string       `json:"genre"`
	Release       string         `json:"release"`
	Region        string         `json:"region"`
	CreatedAt     string         `json:"createdAt"`
	Tipe          string         `json:"tipe"`
	Url           string         `json:"url"`
	UserFavorites []UserFavorite `json:"user_favorites"`
}

type Comments struct {
	Id        int            `json:"id"`
	FilmId    int            `json:"film_id"`
	UserId    int            `json:"user_id"`
	UserUID   string         `json:"user_uid"`
	Username  string         `json:"username"`
	Picture   sql.NullString `json:"picture"`
	Comment   string         `json:"comment"`
	CreatedAt string         `json:"createdAt"`
}

type CardTokenAndAuthRequest struct {
	TokenID string `json:"token_id"`
	Secure  bool   `json:"authenticate_3ds"`
}

type StatusTransactionRequest struct {
	TransactionID string `json:"transaction_id"`
}
