extends RayCast2D


var _last_collider = null

func add_to_inventory() -> void:
	if is_colliding():
		var collider = get_collider().get_parent()
		if collider is Weapon:
			current_inventory.add_weapon(collider)
