extends RayCast2D


func _process(_delta: float) -> void:
	if is_colliding():
		var collider = get_collider()
		if collider.get_parent() is Weapon:
			current_inventory.weapons[0] = collider.get_parent()
			get_tree().current_scene.remove_child(collider.get_parent())
