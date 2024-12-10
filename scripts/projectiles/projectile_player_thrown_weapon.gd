class_name ProjectileThrownWeapon
extends ProjectilePlayer

@export var rotation_rate: float = 20.0
@export var explosion_projectile: PackedScene
@export var explosion_effect: PackedScene

@onready var sprite: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	super(delta)
	rotation_degrees += rotation_rate

func _on_body_entered(body: Node2D):
	var explosion: ProjectilePlayer = explosion_projectile.instantiate()
	add_sibling(explosion)
	explosion.global_position = global_position
	explosion.set_properties(damage, type, 0)
	var effect: Sprite2D = explosion_effect.instantiate()
	add_sibling(effect)
	effect.global_position = global_position
	super(body)
	game_manager.shake_camera.emit(0.5)

func get_sprite() -> Sprite2D:
	return sprite
