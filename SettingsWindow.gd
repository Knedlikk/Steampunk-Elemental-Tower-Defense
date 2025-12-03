extends Window

func _on_back_button_pressed() -> void:
	if has_method("hide"):
		hide()
	else:
		queue_free()

func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/Menu.tscn")
