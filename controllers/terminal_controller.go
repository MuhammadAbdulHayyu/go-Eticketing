package controllers

import (
    "github.com/gofiber/fiber/v2"
    "go-eticketing/database"
    "go-eticketing/models"
)

func CreateTerminal(c *fiber.Ctx) error {
    var terminal models.Terminal
    if err := c.BodyParser(&terminal); err != nil {
        return c.Status(400).JSON(fiber.Map{"error": "Invalid input"})
    }

   
    var newID int64
    err := database.DB.QueryRow(
        "INSERT INTO terminals (name, location, code) VALUES ($1, $2, $3) RETURNING id",
        terminal.Name, terminal.Location, terminal.Code,
    ).Scan(&newID)

    if err != nil {
        return c.Status(500).JSON(fiber.Map{"error": "Failed to create terminal"})
    }

    return c.JSON(fiber.Map{
        "message": "Terminal created successfully",
        "data": fiber.Map{
            "id":       newID,
            "name":     terminal.Name,
            "location": terminal.Location,
            "code":     terminal.Code,
        },
    })
}
