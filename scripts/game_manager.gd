class_name GameManager
extends Node


var level_1:PackedScene = preload("res://scenes/demo/demo_level_1.tscn")
var enemies_remaining = 0
var room_active = false
var room_id = 0


func _process(_delta: float) -> void:		
	# demo to switch between levels
	if Input.is_action_just_pressed("start_demo"):
		get_tree().change_scene_to_packed(level_1)
			
		
			
func change_level(next_level:PackedScene):
	get_tree().change_scene_to_packed(next_level)
