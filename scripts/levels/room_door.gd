class_name RoomDoor
extends StaticBody2D
## A door for a room in the level
##
## Shrinks to allow the player to pass through
## Shrinks when all enemies in the room are defeated

var is_closing: bool = false


func _process(delta: float) -> void:
	if is_closing and scale.y >= 0.5:
		if not audio_manager.is_playing_door_open():
			audio_manager.play_door_open()
		scale.y -= delta 
