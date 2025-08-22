package database

import (
    "fmt"
    "log"

    "github.com/jmoiron/sqlx"
    _ "github.com/jackc/pgx/v5/stdlib"
    "go-eticketing/config"
)

var DB *sqlx.DB

func Connect() {
    dsn := fmt.Sprintf("postgres://%s:%s@%s:%s/%s?sslmode=disable",
        config.DB_USER, config.DB_PASSWORD, config.DB_HOST, config.DB_PORT, config.DB_NAME)

    db, err := sqlx.Connect("pgx", dsn)
    if err != nil {
        log.Fatal("Database connection failed:", err)
    }

    DB = db
    fmt.Println("Connected to PostgreSQL")
}
