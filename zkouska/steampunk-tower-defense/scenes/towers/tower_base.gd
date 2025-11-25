extends Node2D

class_name TowerBase

export(int) var damage = 10
export(int) var range = 100
export(float) var fire_rate = 1.0

var target = null
var attack_timer = 0.0

func _ready():
    attack_timer = fire_rate

func _process(delta):
    if target:
        attack_timer -= delta
        if attack_timer <= 0:
            attack()
            attack_timer = fire_rate

func attack():
    if target:
        target.take_damage(damage)