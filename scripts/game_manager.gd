class_name GameManager
extends Node


signal room_over(room_id:int)

var level_1:PackedScene = preload("res://scenes/demo/demo_level_1.tscn")
var enemies_remaining = 0
var room_active = false
var room_id = 0


func _process(_delta: float) -> void:		
	# switch to the room demo
	if Input.is_action_just_pressed("start_demo"):
		get_tree().change_scene_to_packed(level_1)
	# kill enemy in demo
	if Input.is_action_just_pressed("kill _enemy"):
		enemies_remaining -= 1
		print("enemies remaining: ", enemies_remaining)
			
	if room_active and enemies_remaining == 0:
		room_over.emit(room_id)	
		room_active = false
			
func change_level(next_level:PackedScene):
	room_id = 0
	get_tree().change_scene_to_packed(next_level)
