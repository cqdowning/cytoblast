class_name GameManager
extends Node


signal room_over(room_id: int)
signal enemy_defeated
signal health_changed(current_health: int, max_health: int)
signal weapon_switched(weapon:Weapon, new_weapon_index: int)
signal no_weapon()
signal ammo_changed(current_ammo: int, max_ammo: int)
signal weapon_dropped(index: int)
signal shake_camera(magnitude: float)
signal player_death

var hud_scene: PackedScene = preload("res://scenes/hud.tscn")
var enemies_remaining: int = 0
var room_active = false
var room_id = 0


func _ready() -> void:
	player_death.connect(_on_player_death)
	enemy_defeated.connect(_on_enemy_defeated)


func _process(_delta: float) -> void:		
	# emit signal once the room is complete
	if room_active and enemies_remaining == 0:
		room_over.emit(room_id)	
		room_active = false


func change_level(next_level: PackedScene) -> void:
	# reset the room id, each level's rooms will be indexed starting at 1
	room_id = 0
	get_tree().call_deferred("change_scene_to_packed", next_level)
	current_inventory.reset()
	show_hud()


func show_hud() -> void:
	var hud = hud_scene.instantiate()
	get_tree().get_root().add_child(hud)
	

func _on_enemy_defeated() -> void:
	enemies_remaining -= 1
	

func _on_player_death() -> void:
	_restart_level()


func _restart_level() -> void:
	room_id = 0
	current_inventory.reset()
	get_tree().reload_current_scene()
