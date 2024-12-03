class_name Weapon
extends Sprite2D

enum Type {
	ANTIBIOTIC,
	ANTIVIRAL,
	ANTIPARASITIC,
}

@export var damage:int = 1.0
@export var type:Type = Type.ANTIBIOTIC
@export var shoot_delay:float = 0.5

var _shoot_delay_timer:Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	_shoot_delay_timer = Timer.new()
	add_child(_shoot_delay_timer)
	_shoot_delay_timer.one_shot = false
	_shoot_delay_timer.timeout.connect(shoot)
	activate_weapon()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func activate_weapon():
	_shoot_delay_timer.start(shoot_delay)

func deactivate_weapon():
	_shoot_delay_timer.stop()

func shoot():
	print("pew!")
