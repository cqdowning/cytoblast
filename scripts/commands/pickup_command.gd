class_name PickupCommand
extends Command

func execute(player: CharacterBody2D) -> Status:
	if player.has_method("pickup_weapon"):
		player.pickup_weapon()
		return Status.DONE
	return Status.ERROR
