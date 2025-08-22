package middleware

import (
    "github.com/gofiber/fiber/v2"
    "github.com/golang-jwt/jwt/v5"
    "go-eticketing/config"
)

func JWTMiddleware(c *fiber.Ctx) error {
    tokenString := c.Get("Authorization")
    if tokenString == "" {
        return c.Status(401).JSON(fiber.Map{"error": "Missing token"})
    }

    token, err := jwt.Parse(tokenString, func(t *jwt.Token) (interface{}, error) {
        return []byte(config.JWT_SECRET), nil
    })

    if err != nil || !token.Valid {
        return c.Status(401).JSON(fiber.Map{"error": "Invalid token"})
    }

    return c.Next()
}
