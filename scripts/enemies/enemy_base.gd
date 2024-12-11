class_name Enemy
extends RigidBody2D

enum Type {
	BACTERIA,
	VIRUS,
	PARASITE,
	NONE,
}

@export var target: Player
@export var damage: float = 10.0
@export var health: float = 100.0
@export var type: Type = Type.BACTERIA
@export var move_speed: float = 150.0
@export var rotation_speed: float = 10.0
@export var attack_delay: float = -1.0
@export var attack_speed: float = -1.0
@export var weapon_drops: Array[PackedScene]
@export var projectile_scene = preload("res://scenes/projectiles/projectile.tscn")

var _attack_delay_timer: Timer
var _movement_timer: Timer
var _rng: RandomNumberGenerator

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("enemies")
	_rng = RandomNumberGenerator.new()
	for child in get_children():
		if child is Area2D:
			child.body_entered.connect(_on_body_entered)
			
	if attack_delay > 0.0:
		_attack_delay_timer = Timer.new()
		add_child(_attack_delay_timer)
		_attack_delay_timer.one_shot = true
		_attack_delay_timer.timeout.connect(_attack)

	_movement_timer = Timer.new()
	add_child(_movement_timer)
	_movement_timer.one_shot = true
	_movement_timer.timeout.connect(_on_movement_timeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_ai(delta)
	if health <= 0:
		game_manager.enemy_defeated.emit()
		if not weapon_drops.is_empty():
			var weapon_to_drop = weapon_drops.pick_random()
			var drop = weapon_to_drop.instantiate() as Weapon
			get_tree().current_scene.add_child(drop)
			drop.global_position = global_position
			drop.is_equipped = false
		queue_free()
	
func take_damage(projectile_damage: float):
	health -= projectile_damage
	audio_manager.play_enemy_hit_marker()
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

func move_in_direction(direction: Vector2, delta: float):
	move_and_collide(direction * move_speed * delta)

func get_random_direction() -> Vector2:
	return Vector2.from_angle(_rng.randf() * 2 * PI)

func start_movement_timer(duration: float):
	_movement_timer.start(duration)

func _on_movement_timeout():
	pass

func _ai(delta):
	pass
	
func _attack():
	pass

func _on_body_entered(body):
	if body.is_in_group("player") and body.has_method("take_damage"):
		body.take_damage(damage)
