class_name ControllerCommand
extends Node

# Exported variable for the Player
@export var player: Player

func _ready():
	# Verify player reference exists
	if not player:
		push_error("Controller: Player node not assigned!")
		return
	
	# Ensure player starts in idle state
	player.change_state(Player.PlayerState.IDLE)
	# ...existing code...

func _process(delta):
	var direction = Vector2()
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	
	player.move(direction)
	
	if Input.is_action_just_pressed("attack"):
		player.perform_melee()
	# ...existing code...
