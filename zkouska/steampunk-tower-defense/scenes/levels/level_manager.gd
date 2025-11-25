extends Node

class_name LevelManager

var enemies_to_spawn = []
var current_level = 1

func _ready():
    start_level()

func start_level():
    # Initialize the level and spawn enemies
    spawn_enemies()

func spawn_enemies():
    # Logic to spawn enemies based on the current level
    for enemy_type in enemies_to_spawn:
        # Code to instantiate and add enemies to the scene
        pass