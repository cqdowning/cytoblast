class_name Turret
extends Enemy

var PROJECTILE_COUNT = 8
var MOVEMENT_DURATION = 0.5
var MOVEMENT_COOLDOWN = 3.0
var current_direction = Vector2.ZERO

func _ready():
	super()
	type = Type.VIRUS
	start_movement_timer(MOVEMENT_DURATION)
	

func _ai(delta):
	super(delta)
	if current_direction != Vector2.ZERO:
		move_in_direction(current_direction, delta)

func _on_movement_timeout():
	if current_direction == Vector2.ZERO:
		# Start moving
		current_direction = get_random_direction()
		start_movement_timer(MOVEMENT_DURATION)
	else:
		# Stop moving and attack
		current_direction = Vector2.ZERO
		_attack()
		start_movement_timer(MOVEMENT_COOLDOWN)

func _attack():
	super()
	# Fire projectiles in a ring pattern
	for i in range(PROJECTILE_COUNT):
		var angle = (2 * PI * i) / PROJECTILE_COUNT
		var direction = Vector2.from_angle(angle)
		
		var projectile = projectile_scene.instantiate() as Projectile
		get_tree().current_scene.add_child(projectile)
		projectile.set_properties(damage, Weapon.Type.NONE, attack_speed)
		projectile.launch(global_position, direction)
	audio_manager.play_turret_shoot()
