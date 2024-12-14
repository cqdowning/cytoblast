class_name ItemDetector
extends Area2D
## Collision for picking up items
##
## Attached to the player
## Adds weapons or health to the player


func add_to_player(player: Player) -> void:
	for collider in get_overlapping_areas():
		var item: Node2D = collider.get_parent()
		if item is Weapon:
			current_inventory.add_weapon(item)
		if item is HealthDrop:
			audio_manager.play_health_pickup()
			player.heal(item.heal_amount)
			item.queue_free()
