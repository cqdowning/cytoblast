class_name Level
extends Node2D
## Handles level logic
##
## Keeps track of which room the player is in
## Moves the player to the next level upon reaching the end

@export var next_level: PackedScene

var _room_door_timer: Timer

@onready var player: Player = $Player
@onready var spawn_point: Marker2D = $SpawnPoint


func _ready() -> void:
	player.position = spawn_point.position
	game_manager.room_over.connect(_on_room_over)
	_room_door_timer = Timer.new()
	_room_door_timer.one_shot = true
	_room_door_timer.timeout.connect(_on_door_timer)
	add_child(_room_door_timer)


func _process(_delta) -> void:
	# Debug key, leaving this in to make testing and experiencing the entire game easier
	if Input.is_action_just_pressed("skip"):
		_on_level_end_gate_body_entered(player)


func _on_level_end_gate_body_entered(body: Node2D) -> void:
	# switch to the next level once the player collides with the trigger
	if body is Player:
		for child in player.get_children():
			if child is Weapon:
				# using remove_child instead of queue_free because we just want to 
				# remove it from the player, not delete it entirely
				player.remove_child(child)
		game_manager.change_level(next_level)


func _on_room_over(_room_id:int) -> void:
	# open the correct door depending on the room we are in after delay
	_room_door_timer.start(1)


func _on_door_timer() -> void:
	var current_room: String = "RoomEntrance" + str(game_manager.room_id)
	for child in get_children():
		if child.name == current_room:
			child.door.is_closing = true
