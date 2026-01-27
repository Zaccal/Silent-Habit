package hander

import (
	"encoding/json"
	"io"
	"net/http"

	"github.com/Zaccal/Silent-Habit/internal/database"
	"github.com/Zaccal/Silent-Habit/internal/model"
	"github.com/Zaccal/Silent-Habit/pkg"
)

func HabitHandlers(w http.ResponseWriter, r *http.Request) {
	switch r.Method {
	case http.MethodGet:
		habitGetHandler(w, r)
	case http.MethodPost:
		habitPostHandler(w, r)
	default:
		http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
	}
}

func habitGetHandler(w http.ResponseWriter, r *http.Request) {
	database.HabitsMu.Lock()
	defer database.HabitsMu.Unlock()

	hbs := make([]model.Habit, 0, len(database.Habits))
	for _, habit := range database.Habits {
		hbs = append(hbs, habit)
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(hbs)
}

func habitPostHandler(w http.ResponseWriter, r *http.Request) {
	var h model.Habit
	body, err := io.ReadAll(r.Body)
	if err != nil {
		http.Error(w, "Error reading request body", http.StatusBadRequest)
		return
	}
	if err := json.Unmarshal(body, &h); err != nil {
		http.Error(w, "Unable to parse request body", http.StatusBadRequest)
		return
	}

	database.HabitsMu.Lock()
	defer database.HabitsMu.Unlock()

	h.ID = pkg.GenerateID()
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(h)
}
