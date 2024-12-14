extends Button
## Button to take player to credits

func _ready():
	pass


func _on_pressed():
	# jump to scene level_1.tscn
	get_tree().change_scene_to_file("res://scenes/credits.tscn")
