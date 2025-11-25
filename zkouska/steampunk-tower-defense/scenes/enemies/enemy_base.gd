extends Node2D

class_name EnemyBase

export(int) var health = 100
export(float) var speed = 100.0
export(int) var damage = 10

func _process(delta):
    # Handle enemy movement logic here
    pass

func take_damage(amount):
    health -= amount
    if health <= 0:
        queue_free()  # Remove the enemy from the scene when health is zero or less