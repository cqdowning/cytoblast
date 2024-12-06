class_name Enemy
extends RigidBody2D

enum Type {
	BACTERIA,
	VIRUS,
	PARASITE,
}

@export var target:Player
@export var damage:int = 10
@export var health:int = 100
@export var type:Type = Type.BACTERIA
@export var move_speed:float = 150.0


var _shoot_delay_timer:Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_ai(delta)

func _ai(delta):
	global_position = global_position.move_toward(target.global_position, move_speed * delta)
