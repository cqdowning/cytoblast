extends Button
## Button to take player back to title screen

func _ready():
	pass

func _on_pressed():
	# Jump to scene level_1.tscn
	get_tree().change_scene_to_file("res://scenes/main.tscn")
