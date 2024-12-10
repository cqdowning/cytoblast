extends RayCast2D


var _last_collider = null

# highlight the weapon we are looking at
func _process(delta: float) -> void:
	if is_colliding():
		var curr_collider = get_collider().get_parent()
		if curr_collider is Weapon and curr_collider != _last_collider:
			curr_collider.modulate = Color(1.5, 1.5, 1.5)
			_last_collider = curr_collider
	else:
		if _last_collider != null:
			_last_collider.modulate = Color(1,1,1)
			_last_collider = null

func add_to_inventory() -> void:
	if is_colliding():
		var collider = get_collider().get_parent()
		if collider is Weapon:
			current_inventory.add_weapon(collider)
