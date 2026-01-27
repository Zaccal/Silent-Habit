package hander

import (
	"encoding/json"
	"net/http"

	"github.com/Zaccal/Silent-Habit/internal/model"
)

func HealthCheckHandler(w http.ResponseWriter, r *http.Request) {
	dt := model.HealthCheck{
		Status:  "alive",
		Message: "Ping pong",
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(dt)
}
