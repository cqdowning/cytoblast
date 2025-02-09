extends Control
## Player HUD
##
## Displays player health
## Shows the player's inventory and currently selected weapon w/ ammo

# References to HUD elements
@onready var health_bar = $HealthContainer/HealthBar
@onready var weapon_container = $Inventory
@onready var ammo_label = $Inventory/AmmoLabel
@onready var weapons_container = $Inventory/WeaponsContainer
@onready var rifle_label = $Inventory/WeaponsContainer/Rifle
@onready var shotgun_label = $Inventory/WeaponsContainer/Shotgun
@onready var machinegun_label = $Inventory/WeaponsContainer/MachineGun
@onready var slot_0 = $Weapons/Slot0
@onready var slot_1 = $Weapons/Slot1
@onready var slot_2 = $Weapons/Slot2
@onready var game_manager = get_node("/root/game_manager")

# Store weapon information
var weapon: Weapon
var index: int 


func _ready() -> void:
	# Set initial health bar value to 100%
	health_bar.max_value = 100
	health_bar.value = 100
	
	# Connect to player signals
	_connect_player_signals()
	_no_weapon()


func _connect_player_signals() -> void:
	game_manager.health_changed.connect(_on_health_changed)
	game_manager.no_weapon.connect(_no_weapon)
	game_manager.weapon_switched.connect(_on_weapon_switched)
	game_manager.ammo_changed.connect(_on_ammo_shot)
	game_manager.weapon_dropped.connect(_on_weapon_dropped)
	current_inventory.weapon_added.connect(_on_weapon_added)


func _on_health_changed(current_health, max_health) -> void:
	# Update health bar
	health_bar.max_value = max_health
	health_bar.value = current_health


func _no_weapon() -> void:
	# Clear weapon display
	rifle_label.modulate = Color(0.5, 0.5, 0.5, 1)
	shotgun_label.modulate = Color(0.5, 0.5, 0.5, 1)
	machinegun_label.modulate = Color(0.5, 0.5, 0.5, 1)
	ammo_label.text = "0 / 0"


func _on_weapon_dropped(dropped_index: int) -> void:
	# Set the ammo to 0 when weapon is dropped
	ammo_label.text = "%d / %d" % [0, 0]
	
	match dropped_index:
		0:
			slot_0.texture = null
		1:
			slot_1.texture = null
		2:
			slot_2.texture = null
		_:
			pass


func _on_weapon_switched(new_weapon: Weapon, new_weapon_index: int) -> void:
	# Switch the current weapon
	weapon = new_weapon
	index = new_weapon_index
	_update_weapon_display()
	_highlight_slot(new_weapon_index)


func _on_ammo_shot(current_ammo, _given_max_ammo) -> void:
	# Update ammo display for current weapon
	ammo_label.text = "%d / %d" % [weapon.current_ammo, weapon.max_ammo]


func _on_weapon_added(new_weapon:Weapon, slot:int) -> void:
	match slot:
		0:
			slot_0.texture = new_weapon.texture
		1:
			slot_1.texture = new_weapon.texture
		2:
			slot_2.texture = new_weapon.texture
		_:
			pass


func _highlight_slot(slot:int):
	slot_0.modulate = Color(0.5, 0.5, 0.5, 1)
	slot_1.modulate = Color(0.5, 0.5, 0.5, 1)
	slot_2.modulate = Color(0.5, 0.5, 0.5, 1)
	match slot:
		0:
			slot_0.modulate = Color(1, 1, 1, 1)
		1:
			slot_1.modulate = Color(1, 1, 1, 1)
		2:
			slot_2.modulate = Color(1, 1, 1, 1)
		_:
			pass


func _update_weapon_display() -> void:
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
	ammo_label.text = "%d / %d" % [weapon.current_ammo, weapon.max_ammo]


# Optional: Handle window resize events for additional scaling
func _on_resized() -> void:
	# Additional custom scaling logic if needed
	pass
