extends Control

# References to HUD elements
@onready var health_bar = $HealthContainer/HealthBar
@onready var weapon_container = $WeaponContainer
@onready var current_weapon_label = $WeaponContainer/CurrentWeaponLabel
@onready var ammo_label = $WeaponContainer/AmmoLabel
@onready var game_manager = get_node("/root/game_manager")

# Store weapon information
var weapon_slots = []
var current_weapon_index = 0

func _ready():
	# Set initial health bar value to 100%
	health_bar.max_value = 100
	health_bar.value = 100
	
	# Connect to player signals
	connect_player_signals()

func connect_player_signals():
	game_manager.health_changed.connect(_on_health_changed)
	game_manager.weapon_added.connect(_on_weapon_added)
	game_manager.weapon_switched.connect(_on_weapon_switched)
	game_manager.ammo_changed.connect(_on_ammo_changed)

func _on_health_changed(current_health, max_health):
	# Update health bar
	health_bar.max_value = max_health
	health_bar.value = current_health

func _on_weapon_added(weapon_name):
	# Add a new weapon to the inventory
	weapon_slots.append(weapon_name)
	update_weapon_display()

func _on_weapon_switched(new_weapon_index):
	# Switch the current weapon
	current_weapon_index = new_weapon_index
	update_weapon_display()

func _on_ammo_changed(current_ammo, max_ammo):
	# Update ammo display for current weapon
	ammo_label.text = "%d / %d" % [current_ammo, max_ammo]

func update_weapon_display():
	# Update the current weapon display
	if weapon_slots.size() > 0 and current_weapon_index < weapon_slots.size():
		current_weapon_label.text = weapon_slots[current_weapon_index]
	else:
		current_weapon_label.text = "No Weapon"

# Optional: Handle window resize events for additional scaling
func _on_resized():
	# Additional custom scaling logic if needed
	pass
