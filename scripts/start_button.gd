extends Button
## Button to take player back to first level

var starting_level: PackedScene = preload("res://scenes/levels/level_1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_pressed() -> void:
	game_manager.change_level(starting_level)
