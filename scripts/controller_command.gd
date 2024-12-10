class_name ControllerCommand
extends Node

@export var player: CharacterBody2D

func _ready():
	# Verify player reference exists
	if not player:
		push_error("Controller: Player node not assigned!")
		return
	
	# Ensure player starts in idle state
	if player.has_method("change_state"):
		player.change_state(0) # 0 = PlayerState.IDLE

func _process(_delta):
	var direction = Vector2()
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	
	# Execute movement or idle command
	var move_command = MoveCommand.new(direction)
	move_command.execute(player)
	
	# Execute melee command
	if Input.is_action_just_pressed("attack"):
		#print("Attack pressed")
		var melee_command = MeleeCommand.new()
		melee_command.execute(player)
	
	# Execute dash command
	if Input.is_action_just_pressed("dash"):
		#print("Dash pressed")
		var dash_command = DashCommand.new(direction)
		dash_command.execute(player)
	
	# Execute shoot command
	if Input.is_action_pressed("shoot"):
			#print("Shoot pressed")
			var shoot_command = ShootCommand.new()
			shoot_command.execute(player)
			
	# Execute shoot command
	if Input.is_action_just_pressed("throw"):
			#print("Throw pressed")
			var throw_command = ThrowCommand.new()
			throw_command.execute(player)
			
	
	if Input.is_action_just_pressed("pickup_weapon"):
			#print("Throw pressed")
			var pickup_command = PickupCommand.new()
			pickup_command.execute(player)
