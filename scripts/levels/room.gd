extends Node2D


@export var door: RoomDoor
@export var spawners: Array[EnemySpawner]

var starting_enemy_count: int

var _entered: bool = false


func _ready():
	for spawner in spawners:
		starting_enemy_count += spawner.enemy_specs.size()


# once room is entered, tell the game manager
func _on_body_entered(body: Node2D) -> void:
	if not _entered and body is Player:
		game_manager.room_active = true
		game_manager.room_id += 1
		game_manager.enemies_remaining = starting_enemy_count
		audio_manager.play_room_entered()
		for spawner in spawners:
			spawner.start_timer()
	_entered = true
