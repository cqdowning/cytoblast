class_name Weapon
extends Sprite2D

enum Type {
	ANTIBIOTIC,
	ANTIVIRAL,
	ANTIPARASITIC,
	NONE
}

@export var damage: float = 10
@export var max_ammo = 10
@export var type: Type = Type.NONE
@export var speed: float = 800
@export var speed_variation: float = 100.0
@export var shoot_delay: float = 0.01
@export var spread: float = 0.0
@export var shake_magnitude: float = 0.0
@export var projectile_scene:PackedScene
@export var curve:Curve

var can_shoot: bool = true
var is_equipped = true
var current_ammo: int = 0

var _shoot_delay_timer: Timer
var _rng: RandomNumberGenerator
var _hover_progress = 0
var _hover_dir = 1

@onready var projectile_spawn:Node2D = $ProjectileSpawn


# Called when the node enters the scene tree for the first time.
func _ready():
	_shoot_delay_timer = Timer.new()
	add_child(_shoot_delay_timer)
	_shoot_delay_timer.one_shot = true
	_shoot_delay_timer.timeout.connect(_on_shoot_delay_timeout) # Fix indentation
	activate_weapon()
	_rng = RandomNumberGenerator.new()
	_set_ammo(max_ammo)

func _process(delta: float) -> void:
	if not is_equipped and curve:
		_hover_progress += delta * _hover_dir
		position.y += curve.sample(_hover_progress) * 0.2
		if _hover_progress < 0 or _hover_progress > 1:
			_hover_dir *= -1
		_hover_progress = clamp(_hover_progress, 0, 1)

func shoot():
	game_manager.shake_camera.emit(shake_magnitude)
	_set_ammo(current_ammo - 1)

func _on_shoot_delay_timeout():
	if current_ammo > 0:
		can_shoot = true

func activate_weapon():
	can_shoot = true

func deactivate_weapon():
	can_shoot = false

func get_weapon_type() -> String:
	if self is Rifle:
		return "Rifle"
	elif self is Shotgun:
		return "Shotgun"
	elif self is Machinegun:
		return "Machine Gun"
	return "Unknown"

func get_type_enum_value() -> int:
	return type

func _set_ammo(amnt: int):
	current_ammo = amnt
	game_manager.ammo_changed.emit(current_ammo, max_ammo)
