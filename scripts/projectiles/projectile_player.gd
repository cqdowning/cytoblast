class_name ProjectilePlayer
extends Projectile


# Called when the node enters the scene tree for the first time.
func _ready():
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	super(delta)


func _on_body_entered(body: Node2D) -> void:
	super(body)
	# Check if we hit an enemy
	if body.is_in_group("enemies") and body.has_method("take_damage"):
		var multiplier = DamageEngine.damage_multiplier(self, body)
		body.take_damage(damage, multiplier)
	
	# Destroy the projectile on any collision except the player
	if not body.is_in_group("player"):
		queue_free()
