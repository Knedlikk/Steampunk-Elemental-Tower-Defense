extends Control

const CONFIG_PATH := "user://settings.cfg"

@onready var slider: HSlider = get_node_or_null("Center/VBox/MasterVolume/MasterVolumeSlider")
@onready var checkbox := get_node_or_null("Center/VBox/Fullscreen/FullscreenCheckBox")
@onready var back_button: Button = get_node_or_null("Center/VBox/BackButton")

func _ready() -> void:
	# Inicializace slideru
	if slider:
		slider.min_value = -80
		slider.max_value = 0
		slider.step = 1

	# Načti uložená nastavení
	var cfg := ConfigFile.new()
	var err := cfg.load(CONFIG_PATH)
	var vol_db: int = 0
	var fullscreen: bool = false

	# Pokud engine umí zjistit aktuální mód okna, použij ho jako výchozí
	if DisplayServer.has_method("window_get_mode"):
		fullscreen = DisplayServer.window_get_mode(0) == DisplayServer.WINDOW_MODE_FULLSCREEN

	if err == OK:
		vol_db = int(cfg.get_value("audio", "master_volume_db", vol_db))
		fullscreen = bool(cfg.get_value("display", "fullscreen", fullscreen))

	# Aplikuj hodnoty do UI (bez přímého zápisu do vlastnosti pressed)
	if slider:
		slider.value = vol_db
	if checkbox:
		if checkbox.has_method("set_pressed"):
			checkbox.call("set_pressed", fullscreen)
		else:
			# fallback (může v některých kombinacích vykřičet chybu)
			checkbox.pressed = fullscreen

	# Aplikuj okamžitě nastavení
	_apply_volume(vol_db)
	_apply_fullscreen(fullscreen)

	# Připoj signály bezpečně
	if slider:
		slider.connect("value_changed", Callable(self, "_on_master_volume_changed"))
	if checkbox:
		checkbox.connect("toggled", Callable(self, "_on_fullscreen_toggled"))
	if back_button:
		back_button.connect("pressed", Callable(self, "_on_back_button_pressed"))


func _on_master_volume_changed(value: float) -> void:
	_apply_volume(value)
	_save_setting("audio", "master_volume_db", int(value))


func _on_fullscreen_toggled(pressed: bool) -> void:
	print("[Settings] fullscreen toggled ->", pressed)
	# Uložíme a ihned aplikujeme
	_apply_fullscreen(pressed)
	_save_setting("display", "fullscreen", pressed)


func _apply_volume(db_value: float) -> void:
	var idx := AudioServer.get_bus_index("Master")
	if idx >= 0:
		AudioServer.set_bus_volume_db(idx, float(db_value))


func _apply_fullscreen(enabled: bool) -> void:
	# Pozn.: v editoru nemusí fungovat úplně stejně jako v exportu
	if Engine.is_editor_hint():
		print("[Settings] Running inside editor — fullscreen behavior may differ")

	# Prefer DisplayServer API (Godot 4)
	if DisplayServer.has_method("window_set_mode"):
		var full_mode := DisplayServer.WINDOW_MODE_FULLSCREEN
		# Pokud chceš borderless a je dostupný, můžeš zkusit WINDOW_MODE_FULLSCREEN_BORDERLESS
		# (nepředpokládáme ho tu pro kompatibilitu)
		var mode := full_mode if enabled else DisplayServer.WINDOW_MODE_WINDOWED
		print("[Settings] DisplayServer.window_set_mode ->", mode)
		DisplayServer.window_set_mode(0, mode)
		return

	# Fallback pro starší API (pokud existuje)
	if OS.has_method("set_window_fullscreen"):
		print("[Settings] OS.call('set_window_fullscreen', %s)" % enabled)
		OS.call("set_window_fullscreen", enabled)
		return

	print("[Settings] No fullscreen API available on this platform")


func _save_setting(section: String, key: String, value) -> void:
	var cfg := ConfigFile.new()
	cfg.load(CONFIG_PATH) # ignorujeme chybu pokud soubor neexistuje
	cfg.set_value(section, key, value)
	cfg.save(CONFIG_PATH)


func _on_back_button_pressed() -> void:
	if ResourceLoader.exists("res://Menu.tscn"):
		get_tree().change_scene_to_file("res://Menu.tscn")
	else:
		push_warning("Menu.tscn not found at res://Menu.tscn")
