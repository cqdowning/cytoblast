class_name HealthDrop
extends Node2D

@export var heal_amount: float = 20.0
@export var curve:Curve

var _hover_progress = 0
var _hover_dir = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if curve:
		_hover_progress += delta * _hover_dir
		position.y += curve.sample(_hover_progress) * 0.2
		if _hover_progress < 0 or _hover_progress > 1:
			_hover_dir *= -1
		_hover_progress = clamp(_hover_progress, 0, 1)
