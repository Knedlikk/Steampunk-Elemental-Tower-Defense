extends Control

const CONFIG_PATH := "user://settings.cfg"

@onready var slider: HSlider = get_node_or_null("Center/VBox/MasterVolume/MasterVolumeSlider")
@onready var checkbox: CheckBox = get_node_or_null("Center/VBox/Fullscreen/FullscreenCheckBox")
@onready var back_button: Button = get_node_or_null("Center/VBox/BackButton")


func _ready() -> void:
	var current_mode = DisplayServer.window_get_mode(0)
	
	var is_fullscreen = (current_mode == DisplayServer.WINDOW_MODE_FULLSCREEN) or (current_mode == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	
	if checkbox:
		checkbox.set_pressed_no_signal(is_fullscreen)

		if checkbox.is_connected("toggled", Callable(self, "_on_checkbox_toggled")):
			checkbox.disconnect("toggled", Callable(self, "_on_checkbox_toggled"))

		checkbox.connect("toggled", Callable(self, "_on_checkbox_toggled"))
	else:
		print("CHYBA: Checkbox nenalezen! Zkontroluj cestu v get_node.")

	if back_button:
		back_button.connect("pressed", Callable(self, "_on_back_pressed"))


func _on_checkbox_toggled(toggled_on: bool) -> void:
	print("Přepínám fullscreen na: ", toggled_on)
	
	if toggled_on:
		DisplayServer.window_set_mode(0, DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(0, DisplayServer.WINDOW_MODE_WINDOWED)


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Menu.tscn")
