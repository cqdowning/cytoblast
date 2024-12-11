class_name Biter
extends Enemy

var CHARGE_SPEED_MULTIPLIER = 5.0
var CHARGE_DURATION = 0.75
var CHARGE_COOLDOWN = 2.0
var is_charging = false

var _direction = Vector2(0, 0)

func _ready():
	super()
	type = Type.PARASITE
	start_movement_timer(CHARGE_COOLDOWN)

func _ai(delta):
	super(delta)
	if not is_charging:
		# Move towards player slowly
		_direction = global_position.direction_to(target.global_position)
		move_in_direction(_direction, delta)
		_face_target(delta)
	else:
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

func _on_body_entered(body):
	if body.is_in_group("player") and body.has_method("take_damage"):
		body.take_damage(damage)
