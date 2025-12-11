extends Node2D


@onready var path_cube = preload("res://Enemies/wawe1.tscn") 
@onready var path_scorp = preload("res://Enemies/wave_scorpion.tscn") 
@onready var path_cyber = preload("res://Enemies/wawe_cybertrong.tscn") 

func _ready():
	# Spustíme první vlnu chvíli po startu hry
	await get_tree().create_timer(2.0).timeout
	start_wave_1()
	await get_tree().create_timer(8.0).timeout
	start_wave_2()
	await get_tree().create_timer(8.0).timeout
	start_wave_3()

func start_wave_1():
	print("Vlna 1!")
	
	for i in range(5):
		spawn_enemy(path_cube)
		await get_tree().create_timer(1.0).timeout


func start_wave_2():
	print("Vlna 2!")
	
	for i in range(4):
		spawn_enemy(path_cube)
		await get_tree().create_timer(1.0).timeout
	
	# Čekej 3 sekundy, než pošleš další skupinu (škorpiony)
	await get_tree().create_timer(3.0).timeout
	
	# 2. ČÁST: Pošli 3 Scorpions
	for i in range(3):
		spawn_enemy(path_scorp) 
		await get_tree().create_timer(1.0).timeout

func start_wave_3():
	print("Vlna 3!")
	
	for i in range(6):
		spawn_enemy(path_scorp)
		await get_tree().create_timer(1.0).timeout
	
	await get_tree().create_timer(2.0).timeout
	
	for i in range(3):
		spawn_enemy(path_cyber) 
		await get_tree().create_timer(1.0).timeout
		

# Pomocná funkce jen pro vytvoření a přidání do scény
func spawn_enemy(path_scene_to_spawn):
	if path_scene_to_spawn:
		var tempPath = path_scene_to_spawn.instantiate()
		add_child(tempPath)
