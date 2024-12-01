class_name Player
extends CharacterBody2D


@export var speed: float = 200.0
@onready var animation_player: AnimationPlayer = $AnimationPlayer

enum PlayerState {IDLE, MOVING, MELEE}
var current_state: PlayerState = PlayerState.IDLE

func _ready():
	# ...existing code...

func _physics_process(delta):
	if current_state != PlayerState.MELEE: # Don't interrupt melee animation
		# Apply movement
		move_and_slide()
		# Check if practically stopped
		if velocity.length() < 0.1:
			change_state(PlayerState.IDLE)

func move(direction: Vector2):
	velocity = direction.normalized() * speed
	if direction.length() > 0:
		change_state(PlayerState.MOVING)
	else:
		change_state(PlayerState.IDLE)
		velocity = Vector2.ZERO # Stop movement when no direction

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

func perform_melee():
	change_state(PlayerState.MELEE)
	await animation_player.animation_finished
	change_state(PlayerState.IDLE)
