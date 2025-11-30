extends Area2D

var speed := 100
var path := []
var path_index := 0

func _ready():
    # Example path, set these positions based on your tilemap/waypoints
    path = [Vector2(0, 64), Vector2(320, 64), Vector2(320, 384)]
    position = path[0]
    path_index = 1

func _physics_process(delta):
    if path_index < path.size():
        var target = path[path_index]
        var direction = (target - position).normalized()
        position += direction * speed * delta
        if position.distance_to(target) < 2:
            path_index += 1
    else:
        queue_free() # Enemy reached goal