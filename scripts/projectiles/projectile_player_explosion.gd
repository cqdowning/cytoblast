class_name ProjectileExplosion
extends ProjectilePlayer
## Explosion projectile after a thrown weapon collides with something
##
## This is the actual collision for the explosion
## Will disappear instantly

# Called when the node enters the scene tree for the first time.
func _ready():
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	super(delta)
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	super(body)
