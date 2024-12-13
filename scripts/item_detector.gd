class_name ItemDetector
extends Area2D


var _last_collider = null

func add_to_player() -> void:
		for collider in get_overlapping_areas():
			var item = collider.get_parent()
			if item is Weapon:
				current_inventory.add_weapon(item)
