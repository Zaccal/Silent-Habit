package main

import (
	"fmt"
	"log"
	"net/http"

	"github.com/Zaccal/Silent-Habit/internal/api/hander"
)

func main() {
	http.HandleFunc("/healthCheck", hander.HealthCheckHandler)
	http.HandleFunc("/habits", hander.HabitHandlers)

	fmt.Println("Server is running at http://localhost:8080")

	log.Fatal(http.ListenAndServe(":8080", nil))
}
