extends Node2D

const SETTINGS_SCENE := "res://SettingsWindow.tscn"

@onready var settings_button: Button = get_node_or_null("SettingsButton") as Button

func _ready() -> void:
	if settings_button:
		if not settings_button.is_connected("pressed", Callable(self, "_on_settings_button_pressed")):
			settings_button.connect("pressed", Callable(self, "_on_settings_button_pressed"))
		print("[Level1] Connected to SettingsButton")
	else:
		push_warning("[Level1] SettingsButton node not found at path 'SettingsButton' (check node name/path)")

func _on_settings_button_pressed() -> void:
	print("[Level1] SettingsButton pressed")
	var parent_node: Node = null
	if get_tree().current_scene and get_tree().current_scene is Node:
		parent_node = get_tree().current_scene as Node
	else:
		parent_node = self

	var existing: Node = parent_node.get_node_or_null("SettingsWindow") as Node
	if existing != null:
		print("[Level1] Found existing SettingsWindow instance in parent")
		_show_instance(existing)
		return

	var packed := ResourceLoader.load(SETTINGS_SCENE) as PackedScene
	if not packed:
		push_warning("[Level1] Could not load PackedScene: %s" % SETTINGS_SCENE)
		return

	var inst: Node = packed.instantiate() as Node
	if not inst:
		push_warning("[Level1] Failed to instantiate scene: %s" % SETTINGS_SCENE)
		return

	inst.name = "SettingsWindow"
	parent_node.add_child(inst)
	print("[Level1] Added SettingsWindow instance to parent:", parent_node.name)

	_show_instance(inst)


func _show_instance(n: Node) -> void:
	if n.has_method("popup_centered"):
		print("[Level1] Calling popup_centered()")
		n.call("popup_centered")
		return
	if n.has_method("popup"):
		print("[Level1] Calling popup()")
		n.call("popup")
		return
	if n.has_method("show"):
		print("[Level1] Calling show()")
		n.call("show")
		if n is CanvasItem:
			(n as CanvasItem).raise_()
		return

	print("[Level1] Instance added but no popup/show method found")
