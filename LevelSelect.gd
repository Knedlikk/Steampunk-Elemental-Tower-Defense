extends Control

@onready var btn_level1 := get_node_or_null("Center/VBox/Level/Level1Button") as Button
@onready var btn_level2 := get_node_or_null("Center/VBox/LevelSelect/Level2Button") as Button
@onready var btn_level3 := get_node_or_null("Center/VBox/LevelSelect/Level3Button") as Button
@onready var btn_back := get_node_or_null("Center/VBox/BackButton") as Button

func _ready() -> void:
	# bezpečně připojíme každé tlačítko ke své funkci
	if btn_level1:
		btn_level1.connect("pressed", Callable(self, "_on_level1_pressed"))
	if btn_level2:
		btn_level2.connect("pressed", Callable(self, "_on_level2_pressed"))
	if btn_level3:
		btn_level3.connect("pressed", Callable(self, "_on_level3_pressed"))
	if btn_back:
		btn_back.connect("pressed", Callable(self, "_on_back_pressed"))

func _on_back_pressed() -> void:
	if ResourceLoader.exists("res://Menu.tscn"):
		get_tree().change_scene_to_file("res://Menu.tscn")
	else:
		push_warning("Menu.tscn not found at res://Menu.tscn")


func _on_level_1_button_pressed() -> void:
	var path := "res://levels/Level1.tscn"
	if ResourceLoader.exists(path):
		get_tree().change_scene_to_file(path)
	else:
		push_warning("Level scene not found: %s" % path)


func _on_level_2_button_pressed() -> void:
	var path := "res://levels/Level2.tscn"
	if ResourceLoader.exists(path):
		get_tree().change_scene_to_file(path)
	else:
		push_warning("Level scene not found: %s" % path)


func _on_level_3_button_pressed() -> void:
	var path := "res://levels/Level3.tscn"
	if ResourceLoader.exists(path):
		get_tree().change_scene_to_file(path)
	else:
		push_warning("Level scene not found: %s" % path)
