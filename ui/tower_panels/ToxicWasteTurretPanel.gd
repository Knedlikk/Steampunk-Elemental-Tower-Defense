extends Panel

@onready var tower = preload("res://Towers/toxic_waste_turret.tscn")
var curTile


func _on_gui_input(event: InputEvent) -> void:
	var temptower = tower.instantiate()
	
	if event is InputEventMouseButton and event.button_mask == 1:
		add_child(temptower)
		temptower.process_mode = Node.PROCESS_MODE_DISABLED

	elif event is InputEventMouseMotion and event.button_mask == 1:
		get_child(1).global_position = event.global_position
		
	elif event is InputEventMouseButton and event.button_mask == 0:
		get_child(1).queue_free()
		
		# Add tower to the world scene
		var path = get_tree().get_root().get_node("Main")   
		path.add_child(temptower)

		# Set position of placed tower
		temptower.global_position = event.global_position

		# Hide area that handles placement preview
		temptower.get_node("Area").hide()
		
	else:
		if get_child_count() > 1:
			get_child(1).queue_free()
