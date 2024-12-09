class_name CameraController
extends Camera2D

@export var subject:Node2D
@export var camera_zoom:Vector2 = Vector2(0.6, 0.6)

func _ready() -> void:
	zoom = camera_zoom
	global_position = subject.global_position
	
	# Make HUD use viewport coordinates
	if $HUD:
		$HUD.position = -get_viewport_rect().size / 2

func _process(_delta: float) -> void:
	global_position = subject.global_position
	
	# Update HUD position to stay in viewport
	if $HUD:
		$HUD.position = -get_viewport_rect().size / 2
