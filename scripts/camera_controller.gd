class_name CameraController
extends Camera2D

@export var subject:Node2D
@export var camera_zoom:Vector2 = Vector2(0.6, 0.6)

func _ready() -> void:
	zoom = camera_zoom
	global_position = subject.global_position


func _process(_delta: float) -> void:
	global_position = subject.global_position
