class_name Projectile
extends Area2D

@export var speed: float = 800.0
@export var damage: int = 1

var direction: Vector2 = Vector2.ZERO

func _ready():
	# Connect the signals
	body_entered.connect(_on_body_entered)
	$VisibleOnScreenNotifier2D.screen_exited.connect(_on_visible_on_screen_notifier_2d_screen_exited)

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

func _on_visible_on_screen_notifier_2d_screen_exited():
	print("Projectile off screen")
	queue_free()
