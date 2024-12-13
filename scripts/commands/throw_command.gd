class_name ThrowCommand
extends Command


func execute(player: CharacterBody2D) -> Status:
	if player.has_method("throw"):
		player.throw()
		return Status.DONE
	return Status.ERROR
