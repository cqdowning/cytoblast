class_name Weapon
extends Sprite2D

enum Type {
	ANTIBIOTIC,
	ANTIVIRAL,
	ANTIPARASITIC,
}

@export var damage: int = 1
@export var type: Type = Type.ANTIBIOTIC
@export var shoot_delay: float = 0.01
var projectile_scene = preload("res://scenes/projectile.tscn")

var _shoot_delay_timer: Timer
var can_shoot: bool = true

@export var rotation_speed: float = 10.0 # Adjust this value for rotation sensitivity

# Called when the node enters the scene tree for the first time.
func _ready():
	_shoot_delay_timer = Timer.new()
	add_child(_shoot_delay_timer)
	_shoot_delay_timer.one_shot = true
	_shoot_delay_timer.timeout.connect(_on_shoot_delay_timeout) # Fix indentation
	activate_weapon()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Get target angle to mouse
	var target_angle = (get_global_mouse_position() - global_position).angle()
	
	# Smoothly rotate towards target angle
	var angle_diff = target_angle - rotation
	# Normalize the angle difference
	angle_diff = fmod(angle_diff + PI, PI * 2) - PI
	# Apply rotation with sensitivity
	rotation += angle_diff * rotation_speed * delta

func shoot():
	if !can_shoot:
		return
		
	can_shoot = false
	
	# Create and setup projectile
	var projectile = projectile_scene.instantiate()
	get_tree().current_scene.add_child(projectile)
	
	# Get direction (from weapon to mouse position)
	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - global_position).normalized()
	
	# Set projectile properties
	projectile.damage = damage
	projectile.launch(global_position, direction)

	# Start cooldown
	_shoot_delay_timer.start(shoot_delay)

func _on_shoot_delay_timeout():
	can_shoot = true

func activate_weapon():
	can_shoot = true

func deactivate_weapon():
	can_shoot = false
