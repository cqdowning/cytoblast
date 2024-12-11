class_name Player
extends CharacterBody2D

@export_category("Combat")
@export var melee_duration: float = 0.8
@export var can_move_while_attacking: bool = true
@export var melee_damage: float = 25.0

@export_category("Movement")
@export var speed: float = 400.0
@export var dash_speed_multiplier: float = 3.0
@export var dash_distance: float = 150.0
@export var dash_cooldown: float = 0.5
@export var rotation_speed: float = 10.0
@export var thrown_weapon_scene: PackedScene
@export var thrown_weapon_damage: float = 50.0
@export var thrown_weapon_speed: float = 1000.0

@export_category("Stats")
@export var max_health: float = 100.0
var current_health: float = max_health

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var melee_hitbox: Area2D = $Area2D
@onready var item_detector: RayCast2D = $ItemDetector


enum PlayerState {IDLE, MOVING, MELEE, DASHING}
var current_state: PlayerState = PlayerState.IDLE
var can_melee: bool = true
var melee_timer: Timer
var can_dash: bool = true
var dash_timer: Timer

func _ready():
	add_to_group("player")
	melee_hitbox.get_child(0).disabled = true
	melee_hitbox.body_entered.connect(_on_melee_entered)
	
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
	
	if not current_inventory.is_empty():
		add_child(current_inventory.current_weapon())
	
	current_inventory.weapon_changed.connect(_on_weapon_changed)
	

	current_health = max_health
	game_manager.health_changed.emit(current_health, max_health)

func _process(delta):
	# Get target angle to mouse
	var target_angle = (get_global_mouse_position() - global_position).angle()
	
	# Smoothly rotate towards target angle
	var angle_diff = target_angle + PI/2 - rotation
	# Normalize the angle difference
	angle_diff = fmod(angle_diff + PI, PI * 2) - PI
	# Apply rotation with sensitivity
	rotation += angle_diff * rotation_speed * delta
	
	if current_health <= 0:
		game_manager.player_death.emit()


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
		if current_state != PlayerState.MELEE:
			change_state(PlayerState.MOVING)
	else:
		velocity = Vector2.ZERO # Stop movement when no direction
		if current_state != PlayerState.MELEE:
			change_state(PlayerState.IDLE)

func perform_melee():
	if !can_melee or current_state == PlayerState.DASHING or !current_inventory.is_empty():
			return
			
	can_melee = false
	change_state(PlayerState.MELEE)

	# Start the melee duration timer
	melee_timer.start()
	audio_manager.play_melee()
	
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
	#print("Perform dash called, can_dash:", can_dash) # Debug print
	if !can_dash or direction.length() == 0:
		#print("Dash cancelled - can_dash:", can_dash, " direction:", direction.length()) # Debug print
		return
	
	#print("Executing dash") # Debug print
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

	for child in get_children():
		if child is Weapon:
			child.shoot()
			return
			
func throw():
	if current_state == PlayerState.DASHING:
		return
	
	if current_inventory.is_empty():
		return
	
	# Create and setup projectile
	var projectile:ProjectileThrownWeapon = thrown_weapon_scene.instantiate()
	get_tree().current_scene.add_child(projectile)
	projectile.get_sprite().set_deferred("texture", current_inventory.current_weapon().texture)
	
	# Get direction (from weapon to mouse position)
	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - global_position).normalized()
	
	# Set projectile properties
	projectile.set_properties(thrown_weapon_damage, current_inventory.current_weapon().type, thrown_weapon_speed)
	projectile.launch(global_position, direction)
	
	audio_manager.play_throw_weapon()
	current_inventory.drop_weapon()

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


func take_damage(amount: float):
	current_health = max(0, current_health - amount)
	audio_manager.play_player_hit_marker()
	game_manager.health_changed.emit(current_health, max_health)

func heal(amount: float):
	current_health = min(max_health, current_health + amount)
	game_manager.health_changed.emit(current_health, max_health)
			
			
func pickup_weapon():
	if item_detector.is_colliding():
		item_detector.add_to_inventory()


func _on_weapon_changed(_cur_slot:int):
	for child in get_children():
		if child is Weapon:
			# using remove_child instead of queue_free because we just want to 
			# remove it from the player, not delete it entirely
			remove_child(child)
	var new_weapon = current_inventory.current_weapon()
	add_child(new_weapon)
	new_weapon.position = $WeaponHolder.position
	game_manager.weapon_switched.emit(new_weapon, _cur_slot)
	
func _on_melee_entered(body: Node2D):
	# Check if we hit an enemy
	if body.is_in_group("enemies") and body.has_method("take_damage"):
		body.take_damage(melee_damage)
