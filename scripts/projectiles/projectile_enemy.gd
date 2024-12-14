class_name ProjectileEnemy
extends Projectile
## Projectile base class for enemy projectiles
##
## These projectiles can collide with players and damage them
## Will not collide with enemies or the player when they are invulnerable

# Called when the node enters the scene tree for the first time.
func _ready():
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	super(delta)


func _on_body_entered(body: Node2D) -> void:
	super(body)
	# Check if we hit a player that is not invulnerable
	if body.is_in_group("player") and not body.is_in_group("invulnerable") and body.has_method("take_damage"):
		body.take_damage(damage)
	
	# Destroy the projectile on any collision except enemies and an invulnerable player
	if not body.is_in_group("enemies") and not body.is_in_group("invulnerable"):
		queue_free()
