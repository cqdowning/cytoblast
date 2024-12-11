class_name GameManager
extends Node


signal room_over(room_id:int)
signal enemy_defeated
signal health_changed(current_health:int, max_health:int)
signal weapon_switched(new_weapon_index:int)
signal no_weapon()
signal ammo_changed(current_ammo:int, max_ammo:int)
signal shake_camera(magnitude:float)

var hud_scene:PackedScene = preload("res://scenes/hud.tscn")
var player: Player
var enemies_remaining = 0
var room_active = false
var room_id = 0


func _ready() -> void:
	enemy_defeated.connect(_on_enemy_defeated)


func _process(_delta: float) -> void:		
	# emit signal once the room is complete
	if room_active and enemies_remaining == 0:
		room_over.emit(room_id)	
		room_active = false
		print("Room ", game_manager.room_id, " completed")
			
func change_level(next_level:PackedScene):
	# reset the room id, each level's rooms will be indexed starting at 1
	room_id = 0
	get_tree().call_deferred("change_scene_to_packed", next_level)
	show_hud()

func _on_enemy_defeated():
	enemies_remaining -= 1
	print("Enemies remaining: ", game_manager.enemies_remaining)
	

func show_hud():
	var hud = hud_scene.instantiate()
	get_tree().get_root().add_child(hud)
