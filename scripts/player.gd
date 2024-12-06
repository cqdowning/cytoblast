class_name Player
extends CharacterBody2D

@export var melee_duration: float = 0.4
@export var can_move_while_attacking: bool = false
@export var speed: float = 300.0
@export var dash_speed_multiplier: float = 2.0
@export var dash_distance: float = 150.0
@export var dash_cooldown: float = 1.5
@export var rotation_speed: float = 10.0

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var weapon = $Weapon


enum PlayerState {IDLE, MOVING, MELEE, DASHING}
var current_state: PlayerState = PlayerState.IDLE
var can_melee: bool = true
var melee_timer: Timer
var can_dash: bool = true
var dash_timer: Timer

func _ready():
	melee_timer = Timer.new()
	melee_timer.one_shot = true
	melee_timer.wait_time = melee_duration
	melee_timer.timeout.connect(_on_melee_completed)
	add_child(melee_timer)

	dash_timer = Timer.new()
	dash_timer.one_shot = true
	dash_timer.wait_time = dash_cooldown
	dash_timer.timeout.connect(_on_dash_cooldown_timeout)
	add_child(dash_timer)

func _process(delta):
	# Get target angle to mouse
	var target_angle = (get_global_mouse_position() - global_position).angle()
	
	# Smoothly rotate towards target angle
	var angle_diff = target_angle + PI/2 - rotation
	# Normalize the angle difference
	angle_diff = fmod(angle_diff + PI, PI * 2) - PI
	# Apply rotation with sensitivity
	rotation += angle_diff * rotation_speed * delta

func _physics_process(delta):
	if current_state != PlayerState.MELEE or can_move_while_attacking:
			# Apply movement
			move_and_slide()
			# Check if practically stopped
			if velocity.length() < 0.1 and current_state != PlayerState.MELEE:
					change_state(PlayerState.IDLE)


func move(direction: Vector2):
	velocity = direction.normalized() * speed
	if direction.length() > 0:
		change_state(PlayerState.MOVING)
	else:
		change_state(PlayerState.IDLE)
		velocity = Vector2.ZERO # Stop movement when no direction

func perform_melee():
	if !can_melee or current_state == PlayerState.DASHING:
			return
			
	can_melee = false
	change_state(PlayerState.MELEE)
	
	# Start the melee duration timer
	melee_timer.start()
	
	# Might want to stop or reduce movement during attack
	if !can_move_while_attacking:
			velocity = Vector2.ZERO

func _on_melee_completed():
	can_melee = true
	if current_state == PlayerState.MELEE:
			# Only change state if we're still in MELEE state
			# (might have changed to DASHING or something else)
			change_state(PlayerState.IDLE)


func perform_dash(direction: Vector2):
	print("Perform dash called, can_dash:", can_dash) # Debug print
	if !can_dash or direction.length() == 0:
		print("Dash cancelled - can_dash:", can_dash, " direction:", direction.length()) # Debug print
		return
	
	print("Executing dash") # Debug print
	can_dash = false
	change_state(PlayerState.DASHING)
	
	# Calculate dash speed and duration
	var dash_speed = speed * dash_speed_multiplier
	var dash_duration = dash_distance / dash_speed
	var time_elapsed = 0.0
	
	# Optional: Add visual feedback
	modulate = Color(1.5, 1.5, 1.5)
	
	# Handle the dash movement over time
	while time_elapsed < dash_duration:
			var delta = get_process_delta_time()
			time_elapsed += delta
			
			# Apply dash movement with collision detection
			velocity = direction.normalized() * dash_speed
			move_and_slide()
			
			# Check if we hit something that blocks our dash direction
			var blocking_dash = false
			for i in get_slide_collision_count():
					var collision = get_slide_collision(i)
					# Calculate dot product between dash direction and collision normal
					var dot_product = direction.normalized().dot(collision.get_normal())
					# If collision is opposing our dash direction (dot product < -0.5)
					if dot_product < -0.5:
							blocking_dash = true
							break
			
			if blocking_dash:
					break
					
			await get_tree().process_frame
	
	# Reset state
	if current_state == PlayerState.DASHING:
			change_state(PlayerState.MOVING)
	modulate = Color(1, 1, 1)
	
	# Start cooldown timer
	dash_timer.start()


func _on_dash_cooldown_timeout():
	can_dash = true

func shoot():
	if current_state == PlayerState.DASHING:
		return

	weapon.shoot()

func change_state(new_state: PlayerState):
	if new_state == current_state:
		return
		
	current_state = new_state
	match current_state:
		PlayerState.IDLE:
			animation_player.play("idle")
		PlayerState.MOVING:
			animation_player.play("moving")
		PlayerState.MELEE:
			animation_player.play("melee")
		PlayerState.DASHING:
			animation_player.play("moving")
