extends Area2D

var attack_cooldown := 1.0
var attack_timer := 0.0
var target : Area2D = null

func _process(delta):
    attack_timer -= delta
    if not target or not is_instance_valid(target):
        target = _find_enemy_in_range()
    if target and attack_timer <= 0.0:
        _attack(target)
        attack_timer = attack_cooldown

func _find_enemy_in_range():
    for body in get_overlapping_bodies():
        if body.is_in_group("enemies"):
            return body
    return null

func _attack(enemy):
    enemy.queue_free() # Simple, instantly destroys the enemy for now