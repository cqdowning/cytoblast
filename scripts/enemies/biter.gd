class_name Biter
extends Enemy

var CHARGE_SPEED_MULTIPLIER = 5.0
var CHARGE_DURATION = 0.75
var CHARGE_COOLDOWN = 2.0
var is_charging = false

var _direction = Vector2(0, 0)
var _is_sound_playing = false

func _ready():
	super()
	type = Type.PARASITE
	start_movement_timer(CHARGE_COOLDOWN)

func _ai(delta):
	super(delta)
	if not is_charging:
		_is_sound_playing = false
		# Move towards player slowly
		_direction = global_position.direction_to(target.global_position)
		move_in_direction(_direction, delta)
		_face_target(delta)
	else:
		if not _is_sound_playing:
			audio_manager.play_biter_attack()
			_is_sound_playing = true
		# Charge in current direction
		move_in_direction(_direction, delta * CHARGE_SPEED_MULTIPLIER)

func _on_movement_timeout():
	if not is_charging:
		# Start charge
		is_charging = true
		start_movement_timer(CHARGE_DURATION)
	else:
		# End charge
		is_charging = false
		start_movement_timer(CHARGE_COOLDOWN)
