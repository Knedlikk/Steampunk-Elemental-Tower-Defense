extends Node

class_name GameManager

var is_game_running: bool = false

func start_game():
    is_game_running = true
    # Initialize game state, load levels, etc.

func end_game():
    is_game_running = false
    # Handle game over conditions, show results, etc.