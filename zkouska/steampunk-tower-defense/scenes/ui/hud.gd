extends Node

class_name HUD

var score: int = 0
var resources: int = 0

func _ready():
    # Initialize HUD elements here
    update_score(score)
    update_resources(resources)

func update_score(new_score: int) -> void:
    score = new_score
    # Update the score display in the HUD

func update_resources(new_resources: int) -> void:
    resources = new_resources
    # Update the resources display in the HUD