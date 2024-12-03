class_name GameManager
extends Node


var level_1:PackedScene = preload("res://scenes/test_level_1.tscn")
var level_2:PackedScene = preload("res://scenes/test_level_2.tscn")
var cur_scene = 1
var enemies_remaining = 0;


func _process(_delta: float) -> void:		
	# demo to switch between levels
	if Input.is_action_just_pressed("ui_accept"):
		if cur_scene == 1:
			get_tree().change_scene_to_packed(level_2)
			cur_scene = 2
		else:
			get_tree().change_scene_to_packed(level_1)
			cur_scene = 1
			
			
func change_level(next_level:PackedScene):
	get_tree().change_scene_to_packed(next_level)
