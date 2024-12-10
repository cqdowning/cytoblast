class_name Level
extends Node2D


@export var next_level:PackedScene

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
		for child in player.get_children():
			if child is Weapon:
				# using remove_child instead of queue_free because we just want to 
				# remove it from the player, not delete it entirely
				player.remove_child(child)
		game_manager.change_level(next_level)


func _on_room_over(room_id:int):
	# remove the correct door depending on the room we are in
	var current_room = "RoomEntrance" + str(game_manager.room_id)
	for child in get_children():
		if child.name == current_room:
			child.door.queue_free()
