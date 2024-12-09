class_name ProjectileExplosion
extends Projectile_Player

# Called when the node enters the scene tree for the first time.
func _ready():
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	super(delta)

func _on_body_entered(body: Node2D):
	super(body)
