class_name Turret
extends Enemy
## The virus enemy
##
## Moves in a random direction
## Fires a ring of projectiles after moving

var PROJECTILE_COUNT: int = 16
var MOVEMENT_DURATION: float = 0.5
var MOVEMENT_COOLDOWN: float = 3.0

var current_direction: Vector2 = Vector2.ZERO


func _ready():
	super()
	type = Type.VIRUS
	_start_movement_timer(MOVEMENT_DURATION)
	

func _ai(delta):
	super(delta)
	if current_direction != Vector2.ZERO:
		_move_in_direction(current_direction, delta)


func _on_movement_timeout() -> void:
	if current_direction == Vector2.ZERO:
		# Start moving
		current_direction = _get_random_direction()
		_start_movement_timer(MOVEMENT_DURATION)
	else:
		# Stop moving and attack
		current_direction = Vector2.ZERO
		_attack()
		_start_movement_timer(MOVEMENT_COOLDOWN)


func _attack() -> void:
	super()
	# Fire projectiles in a ring pattern
	for i in range(PROJECTILE_COUNT):
		var angle: float = (2 * PI * i) / PROJECTILE_COUNT
		var direction: Vector2 = Vector2.from_angle(angle)
		
		var projectile := projectile_scene.instantiate() as Projectile
		get_tree().current_scene.add_child(projectile)
		projectile.set_properties(damage, Weapon.Type.NONE, attack_speed)
		projectile.launch(global_position, direction)
	audio_manager.play_turret_shoot()
