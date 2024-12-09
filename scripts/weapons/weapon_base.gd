class_name Weapon
extends Sprite2D

enum Type {
	ANTIBIOTIC,
	ANTIVIRAL,
	ANTIPARASITIC,
	NONE
}

@export var damage: float = 1
@export var type: Type = Type.NONE
@export var shoot_delay: float = 0.01
@export var projectile_scene:PackedScene

var _shoot_delay_timer: Timer
var can_shoot: bool = true

@onready var projectile_spawn:Node2D = $ProjectileSpawn


# Called when the node enters the scene tree for the first time.
func _ready():
	_shoot_delay_timer = Timer.new()
	add_child(_shoot_delay_timer)
	_shoot_delay_timer.one_shot = true
	_shoot_delay_timer.timeout.connect(_on_shoot_delay_timeout) # Fix indentation
	activate_weapon()


func shoot():
	pass

func _on_shoot_delay_timeout():
	can_shoot = true

func activate_weapon():
	can_shoot = true

func deactivate_weapon():
	can_shoot = false
