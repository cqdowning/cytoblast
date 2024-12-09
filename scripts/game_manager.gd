class_name GameManager
extends Node


signal room_over(room_id:int)
signal health_changed(current_health:int, max_health:int)
signal weapon_added(weapon_name:String)
signal weapon_switched(new_weapon_index:int)
signal ammo_changed(current_ammo:int, max_ammo:int)
signal shake_camera(magnitude:float)

var level_1:PackedScene = preload("res://scenes/demo/demo_level_1.tscn")
var hud_scene:PackedScene = preload("res://scenes/hud.tscn")
var enemies_remaining = 0
var room_active = false
var room_id = 0


func _ready() -> void:
	pass


func _process(_delta: float) -> void:		
	# switch to the room demo (keybind is "9")
	if Input.is_action_just_pressed("start_demo"):
		get_tree().change_scene_to_packed(level_1)
		print("Demo started")
	# kill enemy in demo (keybind is "0")
	if Input.is_action_just_pressed("kill _enemy"):
		enemies_remaining -= 1
		print("enemies remaining: ", enemies_remaining)
			
	# emit signal once the room is complete
	if room_active and enemies_remaining == 0:
		room_over.emit(room_id)	
		room_active = false
			
func change_level(next_level:PackedScene):
	# reset the room id, each level's rooms will be indexed starting at 1
	room_id = 0
	get_tree().change_scene_to_packed(next_level)
	show_hud()

func show_hud():
	var hud = hud_scene.instantiate()
	get_tree().get_root().add_child(hud)
