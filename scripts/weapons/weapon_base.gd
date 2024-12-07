class_name Weapon
extends Sprite2D

enum Type {
	ANTIBIOTIC,
	ANTIVIRAL,
	ANTIPARASITIC,
	NONE
}

@export var damage: int = 1
@export var type: Type = Type.ANTIBIOTIC
@export var shoot_delay: float = 0.01
@export var projectile_scene:PackedScene

var _shoot_delay_timer: Timer
var can_shoot: bool = true


# Called when the node enters the scene tree for the first time.
func _ready():
	_shoot_delay_timer = Timer.new()
	add_child(_shoot_delay_timer)
	_shoot_delay_timer.one_shot = true
	_shoot_delay_timer.timeout.connect(_on_shoot_delay_timeout) # Fix indentation
	activate_weapon()


func shoot():
	if !can_shoot:
		return
		
	can_shoot = false
	
	# Create and setup projectile
	var projectile:Projectile = projectile_scene.instantiate()
	get_tree().current_scene.add_child(projectile)
	
	# Get direction (from weapon to mouse position)
	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - global_position).normalized()
	
	# Set projectile properties
	projectile.set_properties(damage, type, 800)
	projectile.launch(global_position, direction)

	# Start cooldown
	_shoot_delay_timer.start(shoot_delay)

func _on_shoot_delay_timeout():
	can_shoot = true

func activate_weapon():
	can_shoot = true

func deactivate_weapon():
	can_shoot = false
