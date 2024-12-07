class_name Projectile_Player
extends Projectile


# Called when the node enters the scene tree for the first time.
func _ready():
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	super(delta)

func _on_body_entered(body: Node2D):
	super(body)
	# Check if we hit a player
	if body.is_in_group("player") and body.has_method("take_damage"):
		body.take_damage(damage)
	
	# Destroy the projectile on any collision except the player
	if !body.is_in_group("player"):
		queue_free()
