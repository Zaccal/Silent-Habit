package database

import (
	"sync"

	"github.com/Zaccal/Silent-Habit/internal/model"
)

var (
	Habits   = make(map[string]model.Habit)
	HabitsMu sync.Mutex
)
