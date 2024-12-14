class_name Inventory
extends Node
## Inventory singleton for keeping track of player's weapons
##
## Handles level changing and keeping track of enemy and player death
## This class is autoloaded as current_inventory

signal weapon_changed(cur_slot: int)
signal weapon_added(weapon: Weapon, slot: int)

const MAX_SIZE: int = 3

var weapons: Array[Weapon]

var _cur_slot: int = 0


func _ready() -> void:
	for i in range(0, MAX_SIZE):
		weapons.push_back(null)
	
	# set the current slot to the first slot with a weapon
	for i in range(weapons.size()):
		if weapons[i]:
			_cur_slot = i
			return
	
		
func switch_weapon(i: int) -> void:
	var next_slot = _get_next_available_slot(i)
	if next_slot == _cur_slot:
		return
	_cur_slot = next_slot
	weapon_changed.emit(_cur_slot)
	audio_manager.play_weapon_switch()
		
		
func current_weapon() -> Weapon:
	return weapons[_cur_slot]
	
		
func get_current_slot() -> int:
	return _cur_slot
		
		
func is_empty() -> bool:
	for weapon in weapons:
		if weapon:
			return false
	return true
	

func reset() -> void:
	for i in range(0, MAX_SIZE):
		if weapons[i]:
			weapons[i].queue_free()
		weapons[i] = null
	_cur_slot = 0

	
func drop_weapon() -> void:
	if weapons[_cur_slot]:
		weapons[_cur_slot].queue_free()
		weapons[_cur_slot] = null
		game_manager.weapon_dropped.emit(_cur_slot)
		_switch_to_closest_taken_slot()
	

func add_weapon(weapon: Weapon) -> void:
	var picking_up_from_empty = is_empty()
	var slot_to_fill = _get_first_available_slot()
	# only pick up a weapon if there is an open space in the inventory
	if slot_to_fill == -1:
		return
	weapons[slot_to_fill] = weapon
	weapon.is_equipped = true
	# Disable weapon's pickup area once it is equipped
	weapon.pickup_area.monitorable = false
	get_tree().current_scene.remove_child(weapon)
	weapon_added.emit(weapon, slot_to_fill)
	audio_manager.play_weapon_pickup()
	# equip the weapon if the inventory was previously empty
	if picking_up_from_empty:
		weapon_changed.emit(_cur_slot)
	

func _get_first_available_slot() -> int:
	for i in range(weapons.size()):
		# return the first null slot
		if !weapons[i]:
			return i
	return -1 	


# find the next slot that can has a weapon, return _cur_slot if none was found
func _get_next_available_slot(increment: int) -> int:
	var next_slot = _cur_slot + increment
	for i in range(0, MAX_SIZE):
		if next_slot >= MAX_SIZE:
			next_slot = 0
		if next_slot < 0:
			next_slot = MAX_SIZE - 1
		if weapons[next_slot]:
			return next_slot
		next_slot = next_slot + increment
	return _cur_slot
		

func _switch_to_closest_taken_slot() -> void:
	var next_above: int = _get_next_available_slot(1)
	var next_below: int = _get_next_available_slot(-1)
	
	# prioritize autoequipping the next weapon above, then below
	if next_above != _cur_slot:
		_cur_slot = next_above
		weapon_changed.emit(_cur_slot)
	elif next_below != _cur_slot:
		_cur_slot = next_below
		weapon_changed.emit(_cur_slot)
	# if the inventory is empty, set the current slot to 0
	else:
		_cur_slot = 0
		game_manager.no_weapon.emit()
