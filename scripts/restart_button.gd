extends Button
## Button to take player back to level 1

func _ready() -> void:
	pass


func _on_pressed() -> void:
	# Jump to scene level_1.tscn
	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")
