class_name Shotgun
extends Weapon
## Shotgun weapon type
##
## Fires a spread of bullets

@export var projectile_amount: int = 6


# Called when the node enters the scene tree for the first time.
func _ready():
	super()


func shoot() -> void:
	if not can_shoot:
		return
	if current_ammo == 0:
		audio_manager.play_shoot_blank()
		can_shoot = false
		_shoot_delay_timer.start(shoot_delay)
		return
	super()
	can_shoot = false
	
	# Create and setup projectiles
	for i in projectile_amount:
		var projectile: Projectile = projectile_scene.instantiate()
		get_tree().current_scene.add_child(projectile)
	
		# Get direction (from weapon to mouse position)
		var mouse_pos: Vector2 = get_global_mouse_position()
		var direction: Vector2 = (mouse_pos - global_position).normalized()
		direction = direction.rotated(deg_to_rad(_rng.randf_range(-spread * 0.5, spread * 0.5)))
		
		# Set projectile properties
		projectile.set_properties(damage, type, speed + _rng.randf_range(-speed_variation * 0.5, speed_variation * 0.5))
		projectile.launch(projectile_spawn.global_position, direction)

	audio_manager.play_shotgun_shoot()
	# Start cooldown
	_shoot_delay_timer.start(shoot_delay)
