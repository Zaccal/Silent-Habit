package model

type HealthCheck struct {
	Status  string `json:"status"`
	Message string `json:"message"`
}
