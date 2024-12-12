class_name DamageIndicator
extends Label

@export var duration: float = 1.0
@export var movement_curve:Curve
@export var offset: float = 75.0
@export var angle: float = 45.0

var damage:float = 999

var _timer:Timer
var _rng:RandomNumberGenerator
var _elapsed_time:float = 0.0
var _end_location:Vector2 = Vector2(0, 0)

func _ready():
	text = str(roundf(damage))
	_timer = Timer.new()
	add_child(_timer)
	_timer.one_shot = true
	_timer.start(duration)
	
	_rng = RandomNumberGenerator.new()

func _process(delta):
	if _timer != null && !_timer.is_stopped():
		_elapsed_time += delta
		var t:float = _elapsed_time / duration
		global_position = lerp(global_position, _end_location, t)
	if _timer.is_stopped():
		queue_free()


func set_color(color:Color) -> void:
	modulate = color

func update_end_position() -> void:
	_end_location = global_position + Vector2(0, -offset).rotated(deg_to_rad(_rng.randf_range(-angle, angle)))
