class_name Rifle_Antibiotic
extends Weapon


# Called when the node enters the scene tree for the first time.
func _ready():
	super()

func shoot():
	if !can_shoot:
		return
		
	can_shoot = false
	
	# Create and setup projectile
	var projectile:Projectile = projectile_scene.instantiate()
	get_tree().current_scene.add_child(projectile)
	
	# Get direction (from weapon to mouse position)
	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - global_position).normalized()
	
	# Set projectile properties
	projectile.set_properties(damage, type, 800)
	projectile.launch(projectile_spawn.global_position, direction)

	# Start cooldown
	_shoot_delay_timer.start(shoot_delay)
