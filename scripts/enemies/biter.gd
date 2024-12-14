class_name Biter
extends Enemy
## The parasite enemy
##
## Slowly approaches the player then charges in a straight line
## Charges at the end of the movement timer

var CHARGE_SPEED_MULTIPLIER: float = 5.0
var CHARGE_DURATION: float = 0.75
var CHARGE_COOLDOWN: float = 2.0

var is_charging: bool = false

var _direction: Vector2 = Vector2(0, 0)
var _is_sound_playing: bool = false


func _ready():
	super()
	type = Type.PARASITE
	_start_movement_timer(CHARGE_COOLDOWN)


func _ai(delta) -> void:
	super(delta)
	if not is_charging:
		_is_sound_playing = false
		# Move towards player slowly
		_direction = global_position.direction_to(target.global_position)
		_move_in_direction(_direction, delta)
		_face_target(delta)
	else:
		if not _is_sound_playing:
			audio_manager.play_biter_attack()
			_is_sound_playing = true
		# Charge in current direction
		_move_in_direction(_direction, delta * CHARGE_SPEED_MULTIPLIER)


func _on_movement_timeout() -> void:
	if not is_charging:
		# Start charge
		is_charging = true
		_start_movement_timer(CHARGE_DURATION)
	else:
		# End charge
		is_charging = false
		_start_movement_timer(CHARGE_COOLDOWN)
