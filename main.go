package main

import (
    "github.com/gofiber/fiber/v2"
    "go-eticketing/database"
    "go-eticketing/routes"
)

func main() {
    app := fiber.New()

    database.Connect()
    routes.Setup(app)

    app.Listen(":3000")
}
