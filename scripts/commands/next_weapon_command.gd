class_name NextWeaponCommand
extends Command


func execute(_player: CharacterBody2D) -> Status:
	if current_inventory.has_method("switch_weapon"):
		current_inventory.switch_weapon(1)
		return Status.DONE
	return Status.ERROR
