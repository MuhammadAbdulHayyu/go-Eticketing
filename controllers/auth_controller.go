package controllers

import (
	"fmt"
	"time"

	"go-eticketing/config"
	"go-eticketing/database"
	"go-eticketing/models"

	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v5"
)

type LoginInput struct {
	Username string `json:"username"`
	Password string `json:"password"`
}

func Login(c *fiber.Ctx) error {
	var input LoginInput
	if err := c.BodyParser(&input); err != nil {
		return c.Status(400).JSON(fiber.Map{"error": "Invalid input"})
	}

	
	fmt.Printf("DEBUG: Username masuk = %s | Password masuk = %s\n", input.Username, input.Password)

	
	var user models.User
	err := database.DB.Get(&user,
		"SELECT * FROM users WHERE username ILIKE $1 LIMIT 1",
		input.Username)

	
if err != nil {
    
    fmt.Println("DEBUG: error SQL =", err)
    return c.Status(401).JSON(fiber.Map{"error": "User not found"})
}

	
	if user.Password != input.Password {
		fmt.Println("DEBUG: Password tidak cocok")
		return c.Status(401).JSON(fiber.Map{"error": "Invalid password"})
	}

	
	claims := jwt.MapClaims{
		"id":  user.ID,
		"exp": time.Now().Add(time.Hour * 24).Unix(),
	}
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	t, _ := token.SignedString([]byte(config.JWT_SECRET))

	return c.JSON(fiber.Map{
		"token": t,
		"user": fiber.Map{
			"id":        user.ID,
			"username":  user.Username,
			"role":      user.Role,
			"is_active": user.IsActive,
		},
	})
}
