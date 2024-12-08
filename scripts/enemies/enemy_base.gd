class_name Enemy
extends RigidBody2D

enum Type {
	BACTERIA,
	VIRUS,
	PARASITE,
	NONE,
}

@export var target:Player
@export var damage:float = 10.0
@export var health:float = 100.0
@export var type:Type = Type.BACTERIA
@export var move_speed:float = 150.0
@export var rotation_speed:float = 10.0
@export var attack_delay:float = -1.0
@export var attack_speed:float = -1.0
@export var projectile_scene = preload("res://scenes/projectile.tscn")

var _attack_delay_timer:Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("enemies")
	
	if attack_delay > 0.0:
		_attack_delay_timer = Timer.new()
		add_child(_attack_delay_timer)
		_attack_delay_timer.one_shot = true
		_attack_delay_timer.timeout.connect(_attack)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_ai(delta)
	
func take_damage(projectile_damage:float):
	print(projectile_damage)
	health -= projectile_damage
	print(health)
	
func _face_target(delta):
	# Get target angle to mouse
	var target_angle = (target.global_position - global_position).angle()
	
	# Smoothly rotate towards target angle
	var angle_diff = target_angle - rotation
	# Normalize the angle difference
	angle_diff = fmod(angle_diff + PI, PI * 2) - PI
	# Apply rotation with sensitivity
	rotation += angle_diff * rotation_speed * delta

func _ai(delta):
	pass
	
func _attack():
	pass
