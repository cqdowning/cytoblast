extends Button

var starting_level: PackedScene = preload("res://scenes/levels/level_1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var style: StyleBoxFlat = StyleBoxFlat.new()
	style.bg_color = Color("#cb62ed", 0)  # Change to your desired color
	style.corner_radius_top_left = 8    # Optional: rounded corners
	style.corner_radius_top_right = 8
	style.corner_radius_bottom_left = 8
	style.corner_radius_bottom_right = 8
	
	var hover: StyleBoxFlat = StyleBoxFlat.new()
	hover.bg_color = Color("#cb62ed", 0.25)  # Change to your desired color
	# Apply the style to normal state
	add_theme_stylebox_override("normal", style)
	add_theme_stylebox_override("hover", hover)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_pressed() -> void:
	game_manager.change_level(starting_level)
