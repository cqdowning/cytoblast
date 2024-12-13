class_name ShootCommand
extends Command


func execute(player: CharacterBody2D) -> Status:
	if player.has_method("shoot"):
		player.shoot()
		return Status.DONE
	return Status.ERROR
