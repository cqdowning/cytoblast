class_name DashCommand
extends Command

var direction: Vector2

func _init(dash_direction: Vector2):
	direction = dash_direction

func execute(player: CharacterBody2D) -> Status:
	if player.has_method("perform_dash"):
		player.perform_dash(direction)
		return Status.DONE
	return Status.ERROR
