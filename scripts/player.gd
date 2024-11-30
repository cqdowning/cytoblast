class_name Player
extends CharacterBody2D


@export var speed: float = 200.0
@onready var animation_player: AnimationPlayer = $AnimationPlayer

enum PlayerState {IDLE, MOVING, MELEE}
var current_state: PlayerState = PlayerState.IDLE
var velocity: Vector2

func _ready():
	# ...existing code...

func _physics_process(delta):
	if current_state != PlayerState.MELEE:  # Don't interrupt melee animation
		if velocity.length() < 0.1:  # Check if practically stopped
			change_state(PlayerState.IDLE)

func move_right():
	move_and_slide(Vector2(speed, 0))

func move_left():
	move_and_slide(Vector2(-speed, 0))

func move_up():
	move_and_slide(Vector2(0, -speed))

func move_down():
	move_and_slide(Vector2(0, speed))

func move(direction: Vector2):
	velocity = direction.normalized() * speed
	if direction.length() > 0:
		move_and_slide()
		change_state(PlayerState.MOVING)
	else:
		change_state(PlayerState.IDLE)

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
