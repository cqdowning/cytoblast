class_name ControllerCommand
extends Node
## Represents the player controller
## 
## Takes input and calls commands on the player

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
	if Input.is_action_pressed("right"):
		direction.x += 1
	if Input.is_action_pressed("left"):
		direction.x -= 1
	if Input.is_action_pressed("up"):
		direction.y -= 1
	if Input.is_action_pressed("down"):
		direction.y += 1
	
	# Execute movement or idle command
	var move_command: Command = MoveCommand.new(direction)
	move_command.execute(player)
	
	# Execute melee command
	if Input.is_action_pressed("shoot"):
		var melee_command: Command = MeleeCommand.new()
		melee_command.execute(player)
	
	# Execute dash command
	if Input.is_action_just_pressed("dash"):
		var dash_command: Command = DashCommand.new(direction)
		dash_command.execute(player)
	
	# Execute shoot command
	if Input.is_action_pressed("shoot"):
			var shoot_command: Command = ShootCommand.new()
			shoot_command.execute(player)
			
	# Execute shoot command
	if Input.is_action_just_pressed("throw"):
			var throw_command: Command = ThrowCommand.new()
			throw_command.execute(player)
			
	
	if Input.is_action_just_pressed("next_weapon"):
			var next_weapon: Command = NextWeaponCommand.new()
			next_weapon.execute(player)
			
	
	if Input.is_action_just_pressed("prev_weapon"):
			var prev_weapon: Command = PrevWeaponCommand.new()
			prev_weapon.execute(player)
	
