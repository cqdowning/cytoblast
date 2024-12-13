class_name MeleeCommand
extends Command


func execute(player: CharacterBody2D) -> Status:  
	if player.has_method("perform_melee"):
		player.perform_melee()
		return Status.DONE
	return Status.ERROR
