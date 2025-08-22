package routes

import (
    "github.com/gofiber/fiber/v2"
    "go-eticketing/controllers"
    "go-eticketing/middleware"
)

func Setup(app *fiber.App) {
    app.Post("/login", controllers.Login)

    terminal := app.Group("/terminal", middleware.JWTMiddleware)
    terminal.Post("/", controllers.CreateTerminal)
}
