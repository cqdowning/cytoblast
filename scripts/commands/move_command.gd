class_name MoveCommand
extends Command

var direction: Vector2

func _init(move_direction: Vector2):
	direction = move_direction

func execute(player: CharacterBody2D) -> Status:
	if player.has_method("move"):
		player.move(direction)
		return Status.DONE
	return Status.ERROR
