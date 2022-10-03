package routes

import (
	"mova/controllers"
	"mova/models"

	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

func Init() *echo.Echo {
	e := echo.New()

	e.Static("/asset", "asset")
	e.Static("/profile", "profile")
	e.Static("/thumbnail", "thumbnail")
	e.Static("/movies", "movies")
	e.Static("/series", "series")

	//movie
	e.POST("/movie", controllers.AddMovie)

	//series
	e.POST("/series", controllers.AddSeries)

	//google
	e.POST("/registergooglewithpicture", controllers.RegisterGoogleWithPicture)
	e.POST("/registergooglewithoutpicture", controllers.RegisterGoogleWithoutPicture)
	e.POST("/logingoogle", controllers.LoginGoogle)

	//password
	e.POST("/registerpasswordwithpicture", controllers.RegisterPasswordWithPicture)
	e.POST("/registerpasswordwithoutpicture", controllers.RegisterPasswordWithoutPicture)
	e.POST("/loginpassword", controllers.LoginPassword)

	e.POST("/checkusernamephone", controllers.CheckUsernamePhone)
	e.POST("/checkemail", controllers.CheckEmail)
	e.POST("/generatenewtoken", controllers.GenerateNewToken)

	e.GET("/test", controllers.Test)

	r := e.Group("/auth")
	config := middleware.JWTConfig{
		Claims:     &models.JwtCustomClaims{},
		SigningKey: []byte("secret"),
	}
	r.Use(middleware.JWTWithConfig(config))

	//user
	r.GET("/user", controllers.GetUser)
	r.PUT("/editprofilewithpicture", controllers.EditProfileWithPicture)
	r.PUT("/editprofilewithoutpicture", controllers.EditProfileWithoutPicture)

	//movie
	r.GET("/top10movie", controllers.Top10Movie)
	r.GET("/movie/:film_id", controllers.GetMovie)

	//series
	r.GET("/series/:film_id", controllers.GetSeries)

	//film
	r.GET("/top1", controllers.Top1)
	r.GET("/newreleases", controllers.NewReleasesFilm)
	r.GET("/topsearch", controllers.TopSearch)
	r.GET("/topsearchfilter", controllers.TopSearchFilter)
	r.GET("/explore", controllers.Explore)
	r.GET("/explorefilter", controllers.ExploreFilter)
	r.GET("/explore/:title", controllers.ExploreSearch)
	r.GET("/explorefilter/:title", controllers.ExploreSearchFilter)

	//favorite
	r.GET("/favorites", controllers.GetAllFavorites)
	r.GET("/favoritesfilter", controllers.GetAllFavoritesFilter)
	r.POST("/favorite", controllers.AddFavorite)
	r.DELETE("/favorite/:id", controllers.DeleteFavorite)

	//comment
	r.POST("/comment", controllers.AddComment)
	r.GET("/comment/:film_id", controllers.GetAllComment)

	//rating
	r.POST("/rating", controllers.AddRating)

	//payment
	r.POST("/charge_transaction", controllers.ChargeTransaction)
	r.GET("/check_transaction_status", controllers.StatusTransaction)

	return e
}
