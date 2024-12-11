extends Control

# References to HUD elements
@onready var health_bar = $HealthContainer/HealthBar
@onready var weapon_container = $Inventory
@onready var ammo_label = $Inventory/AmmoLabel
@onready var weapons_container = $Inventory/WeaponsContainer
@onready var rifle_label = $Inventory/WeaponsContainer/Rifle
@onready var shotgun_label = $Inventory/WeaponsContainer/Shotgun
@onready var machinegun_label = $Inventory/WeaponsContainer/MachineGun
@onready var game_manager = get_node("/root/game_manager")

# Store weapon information
var weapon: Weapon
var max_ammo = 0

func _ready():
	# Set initial health bar value to 100%
	health_bar.max_value = 100
	health_bar.value = 100
	
	# Connect to player signals
	connect_player_signals()
	_no_weapon()

func connect_player_signals():
	game_manager.health_changed.connect(_on_health_changed)
	game_manager.no_weapon.connect(_no_weapon)
	game_manager.weapon_switched.connect(_on_weapon_switched)
	game_manager.ammo_changed.connect(_on_ammo_shot)

func _on_health_changed(current_health, max_health):
	# Update health bar
	health_bar.max_value = max_health
	health_bar.value = current_health

func _no_weapon():
	# Clear weapon display
	rifle_label.modulate = Color(0.5, 0.5, 0.5, 1)
	shotgun_label.modulate = Color(0.5, 0.5, 0.5, 1)
	machinegun_label.modulate = Color(0.5, 0.5, 0.5, 1)
	ammo_label.text = "0 / 0"

func _on_weapon_switched(new_weapon):
	# Switch the current weapon
	weapon = new_weapon
	update_weapon_display()

func _on_ammo_shot(current_ammo, given_max_ammo):
	# Update ammo display for current weapon
	if current_ammo < 0:
		current_ammo = 0
	ammo_label.text = "%d / %d" % [current_ammo, given_max_ammo]

func update_weapon_display():
	# Highlight the selected weapon
	var highlight_color = Color(0, 1, 1, 1)  # Bright cyan color
	var dimmed_color = Color(0.5, 0.5, 0.5, 1)

	# Set highlight color for selected weapon based on weapon.Type
	if weapon.get_type_enum_value() == Weapon.Type.ANTIBIOTIC:
		highlight_color = Color(0, 1, 0, 1)  # Bright green color
	elif weapon.get_type_enum_value() == Weapon.Type.ANTIVIRAL:
		highlight_color = Color(0, 0, 1, 1)  # Bright blue color
	elif weapon.get_type_enum_value() == Weapon.Type.ANTIPARASITIC:
		highlight_color = Color(1, 0.5, 0, 1)  # Bright orange color
	else:
		highlight_color = Color(0, 1, 1, 1)  # Bright cyan color

	# Get weapon type
	if weapon.get_weapon_type() == "Rifle":
		rifle_label.modulate = highlight_color
		shotgun_label.modulate = dimmed_color
		machinegun_label.modulate = dimmed_color
	elif weapon.get_weapon_type() == "Shotgun":
		shotgun_label.modulate = highlight_color
		rifle_label.modulate = dimmed_color
		machinegun_label.modulate = dimmed_color
	elif weapon.get_weapon_type() == "Machine Gun":
		machinegun_label.modulate = highlight_color
		rifle_label.modulate = dimmed_color
		shotgun_label.modulate = dimmed_color
	else:
		rifle_label.modulate = dimmed_color
		shotgun_label.modulate = dimmed_color
		machinegun_label.modulate = dimmed_color
	
	# Update ammo display for current weapon
	# Max ammo is already set
	ammo_label.text = "%d / %d" % [max_ammo, max_ammo]

# Optional: Handle window resize events for additional scaling
func _on_resized():
	# Additional custom scaling logic if needed
	pass
