extends Node

class_name EnemyManager

var enemies = []
var enemy_scene = preload("res://scenes/enemies/enemy_base.tscn")

func spawn_enemy(enemy_type):
    var enemy_instance = enemy_scene.instance()
    enemy_instance.set_enemy_type(enemy_type)
    get_parent().add_child(enemy_instance)
    enemies.append(enemy_instance)

func update_enemies(delta):
    for enemy in enemies:
        if enemy.is_alive():
            enemy.move(delta)
        else:
            enemies.erase(enemy)