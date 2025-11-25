extends Node

class_name TowerManager

var towers = []

func add_tower(tower):
    towers.append(tower)
    # Additional logic for placing the tower in the game world can be added here

func remove_tower(tower):
    if tower in towers:
        towers.erase(tower)
        # Additional logic for removing the tower from the game world can be added here