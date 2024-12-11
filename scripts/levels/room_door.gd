class_name RoomDoor
extends StaticBody2D


var is_closing = false


func _process(delta: float) -> void:
	if is_closing and scale.y >= 0.5:
		if not audio_manager.is_playing_door_open():
			audio_manager.play_door_open()
		scale.y -= delta 
