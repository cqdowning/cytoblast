class_name Weapon
extends Sprite2D

enum Type {
	ANTIBIOTIC,
	ANTIVIRAL,
	ANTIPARASITIC,
	NONE
}

@export var damage: float = 10
@export var type: Type = Type.NONE
@export var speed: float = 800
@export var speed_variation: float = 100.0
@export var shoot_delay: float = 0.01
@export var spread: float = 0.0
@export var shake_magnitude: float = 0.0
@export var projectile_scene:PackedScene

var can_shoot: bool = true
var is_equipped = false

var _shoot_delay_timer: Timer
var _rng: RandomNumberGenerator

@onready var projectile_spawn:Node2D = $ProjectileSpawn


# Called when the node enters the scene tree for the first time.
func _ready():
	_shoot_delay_timer = Timer.new()
	add_child(_shoot_delay_timer)
	_shoot_delay_timer.one_shot = true
	_shoot_delay_timer.timeout.connect(_on_shoot_delay_timeout) # Fix indentation
	activate_weapon()
	_rng = RandomNumberGenerator.new()


func shoot():
	game_manager.shake_camera.emit(shake_magnitude)

func _on_shoot_delay_timeout():
	can_shoot = true

func activate_weapon():
	can_shoot = true

func deactivate_weapon():
	can_shoot = false

func _on_pickup_area_body_entered(body: Node2D) -> void:
	if body is Player:
		if not is_equipped:
			modulate = Color(1.5, 1.5, 1.5)


func _on_pickup_area_body_exited(body: Node2D) -> void:
	if body is Player:
		modulate = Color(1, 1, 1)
