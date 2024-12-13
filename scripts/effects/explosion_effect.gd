extends Sprite2D

@export var despawn_rate: float = 5.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self_modulate.a -= despawn_rate * delta
