extends Control

const CONFIG_PATH := "user://settings.cfg"

@onready var slider: HSlider = get_node_or_null("Center/VBox/MasterVolume/MasterVolumeSlider")
@onready var checkbox: CheckBox = get_node_or_null("Center/VBox/Fullscreen/FullscreenCheckBox")
@onready var back_button: Button = get_node_or_null("Center/VBox/BackButton")


var _desired_fullscreen: bool = false

func _ready() -> void:
	if slider:
		slider.min_value = -80
		slider.max_value = 0
		slider.step = 1

	var cfg := ConfigFile.new()
	var err := cfg.load(CONFIG_PATH)
	var vol_db: int = 0
	var fullscreen: bool = false


	if DisplayServer.has_method("window_get_mode"):
		var mode = DisplayServer.window_get_mode(0)
		fullscreen = (mode == DisplayServer.WINDOW_MODE_FULLSCREEN or mode == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)

	if err == OK:
		vol_db = int(cfg.get_value("audio", "master_volume_db", vol_db))
		fullscreen = bool(cfg.get_value("display", "fullscreen", fullscreen))

	if slider:
		slider.value = vol_db
	
	if checkbox:
		if checkbox.has_method("set_pressed_no_signal"):
			checkbox.set_pressed_no_signal(fullscreen)
		else:
			checkbox.set_pressed(fullscreen)

	_apply_volume(vol_db)
	_apply_fullscreen(fullscreen)

	if slider:
		slider.connect("value_changed", Callable(self, "_on_master_volume_changed"))
	if checkbox:
		# Connect the toggled signal
		if not checkbox.is_connected("toggled", Callable(self, "_on_fullscreen_toggled")):
			checkbox.connect("toggled", Callable(self, "_on_fullscreen_toggled"))
	if back_button:
		back_button.connect("pressed", Callable(self, "_on_back_button_pressed"))


func _on_master_volume_changed(value: float) -> void:
	_apply_volume(value)
	_save_setting("audio", "master_volume_db", int(value))


func _on_fullscreen_toggled(pressed: bool) -> void:
	print("[Settings] Toggling fullscreen to:", pressed)
	_apply_fullscreen(pressed)
	_save_setting("display", "fullscreen", pressed)


func _apply_volume(db_value: float) -> void:
	var idx := AudioServer.get_bus_index("Master")
	if idx >= 0:
		AudioServer.set_bus_volume_db(idx, float(db_value))


func _apply_fullscreen(enabled: bool) -> void:
	if not DisplayServer.has_method("window_set_mode"):
		print("[Settings] DisplayServer not supported.")
		return

	var current_mode = DisplayServer.window_get_mode(0)
	var target_mode
	
	if enabled:
		# Try EXCLUSIVE_FULLSCREEN first (better performance usually), or regular FULLSCREEN
		target_mode = DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN
	else:
		target_mode = DisplayServer.WINDOW_MODE_WINDOWED
	
	if current_mode != target_mode:
		DisplayServer.window_set_mode(0, target_mode)
		print("[Settings] Setting window mode to:", target_mode)


func _save_setting(section: String, key: String, value) -> void:
	var cfg := ConfigFile.new()
	cfg.load(CONFIG_PATH)
	cfg.set_value(section, key, value)
	cfg.save(CONFIG_PATH)


func _on_back_button_pressed() -> void:
	if ResourceLoader.exists("res://Menu.tscn"):
		get_tree().change_scene_to_file("res://Menu.tscn")
	else:
		push_warning("Menu.tscn not found")
