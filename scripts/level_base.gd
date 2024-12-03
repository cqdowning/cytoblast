class_name Level
extends Node2D


var next_level: PackedScene

@onready var player: Player = $Player
@onready var spawn_point: Marker2D = $SpawnPoint


func _ready() -> void:
	# initialize the player. in the future this will include setting
	# the health, inventory, etc.
	player.position = spawn_point.position
	game_manager.room_over.connect(_on_room_over)


func _on_level_end_gate_body_entered(body: Node2D) -> void:
	# switch to the next level once the player collides with the trigger
	if body is Player:
		print("changing levels")
		game_manager.change_level(next_level)


func _on_room_over(room_id:int):
	# remove the correct door depending on the room we are in
	var door_to_delete = "RoomDoor" + str(game_manager.room_id)
	for child in get_children():
		if child.name == door_to_delete:
			child.queue_free()
