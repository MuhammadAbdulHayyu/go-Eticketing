package models


type Terminal struct {
	ID        int       `db:"id" json:"id"`
	Name      string    `db:"name" json:"name"`
	Location  string    `db:"location" json:"location"`
	Code      string    `db:"code" json:"code"`
	IsActive  bool      `db:"is_active" json:"is_active"`
	
}
