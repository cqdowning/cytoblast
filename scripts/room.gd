extends Node2D


# this is temporary for testing purposes 
# once we have enemies, they should be children of their corresponding room
@export var starting_enemy_count: int
@export var door: RoomDoor

var _entered: bool = false;

# once room is entered, tell the game manager
func _on_body_entered(body: Node2D) -> void:
	if not _entered and body is Player:
		game_manager.room_active = true
		game_manager.room_id += 1
		# this is temporary, actual implementation will add enemies to 
		# an array in the game manager
		game_manager.enemies_remaining = starting_enemy_count
		print("room ", game_manager.room_id, " entered")
	_entered = true
