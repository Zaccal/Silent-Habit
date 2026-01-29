package hander

import (
	"encoding/json"
	"net/http"

	"github.com/Zaccal/Silent-Habit/internal/database"
	"github.com/Zaccal/Silent-Habit/internal/model"
	"github.com/Zaccal/Silent-Habit/pkg"
)

func HabitHandlers(w http.ResponseWriter, r *http.Request) {
	switch r.Method {
	case http.MethodGet:
		habitGetHandler(w)
	case http.MethodPost:
		habitPostHandler(w, r)
	case http.MethodDelete:
		habitDeleteHandler(w, r)
	case http.MethodPut:
		habitPutHandler(w, r)
	default:
		http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
	}
}

func habitGetHandler(w http.ResponseWriter) {
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

func HabitGetByIDHandler(w http.ResponseWriter, r *http.Request) {
	database.HabitsMu.Lock()
	defer database.HabitsMu.Unlock()
	id := r.URL.Query().Get("id")

	if id == "" {
		http.Error(w, "Missing id in query", http.StatusBadRequest)
		return
	}

	if _, ok := database.Habits[id]; !ok {
		http.Error(w, "Habit not found", http.StatusNotFound)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(database.Habits[id])
}

func habitPostHandler(w http.ResponseWriter, r *http.Request) {
	var h model.Habit
	if err := json.NewDecoder(r.Body).Decode(&h); err != nil {
		http.Error(w, "Unable to parse request body", http.StatusBadRequest)
		return
	}

	database.HabitsMu.Lock()
	defer database.HabitsMu.Unlock()

	h.ID = pkg.GenerateID()
	database.Habits[h.ID] = h

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(h)
}

func habitDeleteHandler(w http.ResponseWriter, r *http.Request) {
	database.HabitsMu.Lock()
	defer database.HabitsMu.Unlock()

	id := r.URL.Query().Get("id")
	if id == "" {
		http.Error(w, "Missing id in query", http.StatusBadRequest)
		return
	}

	if _, ok := database.Habits[id]; !ok {
		http.Error(w, "Habit not found", http.StatusNotFound)
		return
	}

	delete(database.Habits, id)
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(map[string]string{
		"status": "deleted",
	})
}

func habitPutHandler(w http.ResponseWriter, r *http.Request) {
	database.HabitsMu.Lock()
	defer database.HabitsMu.Unlock()

	id := r.URL.Query().Get("id")
	if id == "" {
		http.Error(w, "id is missing", http.StatusBadRequest)
		return
	}

	if _, ok := database.Habits[id]; !ok {
		http.Error(w, "Habit not found", http.StatusNotFound)
		return
	}

	var uh model.Habit
	uh.ID = pkg.GenerateID()
	if err := json.NewDecoder(r.Body).Decode(&uh); err != nil {
		http.Error(w, "couldn't decode body", http.StatusBadRequest)
		return
	}

	database.Habits[id] = uh
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(uh)
}
