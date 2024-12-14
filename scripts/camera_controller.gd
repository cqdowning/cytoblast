class_name CameraController
extends Camera2D
## Position lock camera controller
##
## Can apply a screen shake effect

@export var subject: Node2D
@export var camera_zoom: Vector2 = Vector2(0.6, 0.6)
@export var shake_multiplier: float = 10.0

var _shake_timer: Timer
var _rng: RandomNumberGenerator


func _ready() -> void:
	zoom = camera_zoom
	global_position = subject.global_position
	# Make HUD use viewport coordinates
	if $HUD:
		$HUD.position = -get_viewport_rect().size / 2
	game_manager.shake_camera.connect(shake)
	_shake_timer = Timer.new()
	add_child(_shake_timer)
	_shake_timer.one_shot = true
	_rng = RandomNumberGenerator.new()


func _process(_delta: float) -> void:
	if not _shake_timer.is_stopped():
		var offsetX: float = _rng.randf_range(-_shake_timer.time_left, _shake_timer.time_left)
		var offsetY: float = _rng.randf_range(-_shake_timer.time_left, _shake_timer.time_left)
		offset = Vector2(shake_multiplier * offsetX, shake_multiplier * offsetY)
	else:
		offset = Vector2(0, 0)
	global_position = subject.global_position
	# Update HUD position to stay in viewport
	if $HUD:
		$HUD.position = -get_viewport_rect().size / 2


func shake(magnitude: float) -> void:
	if magnitude > 0.0:
		_shake_timer.start(magnitude)
