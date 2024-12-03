class_name CameraController
extends Camera2D

@export var subject:Node2D


func _ready() -> void:
	global_position = subject.global_position


func _process(_delta: float) -> void:
	global_position = subject.global_position
