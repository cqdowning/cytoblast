class_name Projectile
extends Area2D

@export var lifetime: float = 5.0

var direction: Vector2 = Vector2.ZERO
var speed: float
var damage: int
var type: Weapon.Type

var _despawn_timer: Timer

func _ready():
	# Connect the signals
	body_entered.connect(_on_body_entered)
	
	_despawn_timer = Timer.new()
	add_child(_despawn_timer)
	_despawn_timer.one_shot = true
	_despawn_timer.timeout.connect(_on_despawn_timeout)
	_despawn_timer.start(lifetime)

func _physics_process(delta):
	# Move the projectile
	position += direction * speed * delta
	# Optional: rotate projectile in movement direction
	rotation = direction.angle()
	
func set_properties(proj_damage:int, proj_type:Weapon.Type, proj_speed:float):
	damage = proj_damage
	type = proj_type
	speed = proj_speed

func launch(spawn_position: Vector2, launch_direction: Vector2):
	# Initialize the projectile
	position = spawn_position
	direction = launch_direction.normalized()
	rotation = direction.angle()

func _on_body_entered(body: Node2D):
	print("Projectile hit", body, name)

func _on_despawn_timeout():
	queue_free()
