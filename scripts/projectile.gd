class_name Projectile
extends Area2D

@export var speed: float = 800.0
@export var damage: int = 1
@export var lifetime: float = 5.0

var direction: Vector2 = Vector2.ZERO
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

func launch(spawn_position: Vector2, launch_direction: Vector2):
	# Initialize the projectile
	position = spawn_position
	direction = launch_direction.normalized()
	rotation = direction.angle()

func _on_body_entered(body: Node2D):
	# Check if we hit an enemy
	if body.is_in_group("enemies") and body.has_method("take_damage"):
		body.take_damage(damage)
  
	print("Projectile hit", body, name)
	
	# Destroy the projectile on any collision
	queue_free()

func _on_despawn_timeout():
	queue_free()
