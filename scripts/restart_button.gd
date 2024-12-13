extends Button


func _ready():
	var style = StyleBoxFlat.new()
	style.bg_color = Color("#cb62ed", 0)  # Change to your desired color
	style.corner_radius_top_left = 8    # Optional: rounded corners
	style.corner_radius_top_right = 8
	style.corner_radius_bottom_left = 8
	style.corner_radius_bottom_right = 8
	
	var hover = StyleBoxFlat.new()
	hover.bg_color = Color("#cb62ed", 0.25)  # Change to your desired color
	# Apply the style to normal state
	add_theme_stylebox_override("normal", style)
	add_theme_stylebox_override("hover", hover)

func _on_pressed():
	# jump to scene level_1.tscn
	print("Restarting level")
	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")
	print("Level restarted")