class_name Level
extends Node2D


var next_level: PackedScene

@onready var player: Player = $Player
@onready var spawn_point: Marker2D = $SpawnPoint


func _ready() -> void:
	player.global_position = spawn_point.global_position


func _on_level_end_gate_body_entered(body: Node2D) -> void:
	if body is Player:
		game_manager.change_level(next_level)
