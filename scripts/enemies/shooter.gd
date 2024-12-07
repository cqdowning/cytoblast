class_name Shooter
extends Enemy

var RANGE:float = 500.0
var MARGIN:float = 10.0

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	_shoot_delay_timer.start(shoot_delay)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)
	
func _ai(delta):
	super(delta)
	var distance:float = global_position.distance_to(target.global_position)
	var direction_towards_player:Vector2 = global_position.direction_to(target.global_position)
	
	if distance > RANGE + MARGIN:
		move_and_collide(move_speed * delta * direction_towards_player)
	elif distance < RANGE - MARGIN:
		move_and_collide(move_speed * delta * -direction_towards_player)
		
	_face_target(delta)

func _shoot():
	var projectile:Projectile = projectile_scene.instantiate()
	get_tree().current_scene.add_child(projectile)
	var direction_towards_player:Vector2 = global_position.direction_to(target.global_position)
	
	# Set projectile properties
	projectile.set_properties(damage, Weapon.Type.NONE, shoot_speed)
	projectile.launch(global_position, direction_towards_player)

	# Start cooldown
	_shoot_delay_timer.start(shoot_delay)
