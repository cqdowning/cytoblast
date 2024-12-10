class_name Inventory
extends Node


signal weapon_changed

@export var max_size = 3

var weapons:Array[Weapon]
var rifle_ab = preload("res://scenes/weapons/weapon_antibiotic_rifle.tscn").instantiate() as Weapon
var rifle_av = preload("res://scenes/weapons/weapon_antiviral_rifle.tscn").instantiate() as Weapon
var rifle_ap = preload("res://scenes/weapons/weapon_antiparasitic_rifle.tscn").instantiate() as Weapon

var _cur_slot = 0


func _ready() -> void:
	# demo inverntory with all three rifles
	rifle_ab.is_equipped = true
	weapons.push_back(rifle_ab)
	weapons.push_back(null)
	weapons.push_back(null)
	
	# set the current slot to the first slot with a weapon
	for i in range(weapons.size()):
		if weapons[i]:
			_cur_slot = i
			return
	
		
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("next_weapon"):
		var next_slot = _get_next_available_slot(1)
		if next_slot == _cur_slot:
			return
		_cur_slot = next_slot
		weapon_changed.emit()
		print(_cur_slot)
		
	if Input.is_action_just_pressed("prev_weapon"):
		var next_slot = _get_next_available_slot(-1)
		if next_slot == _cur_slot:
			return
		_cur_slot = next_slot
		weapon_changed.emit()
		print(_cur_slot)
		
		
func current_weapon():
	return weapons[_cur_slot]
	
		
func is_empty():
	for weapon in weapons:
		if weapon:
			return false
	return true
	
	
func drop_weapon():
	if weapons[_cur_slot]:
		weapons[_cur_slot].queue_free()
		weapons[_cur_slot] = null
		_switch_to_closest_taken_slot()
	
	
func _get_next_available_slot(increment:int):
	var next_slot = _cur_slot + increment
	while next_slot < max_size and next_slot >= 0:
		if weapons[next_slot]:
			return next_slot
		next_slot = next_slot + increment
	return _cur_slot
		

func _switch_to_closest_taken_slot():
	var next_above = _get_next_available_slot(1)
	var next_below = _get_next_available_slot(-1)
	
	# prioritize autoequipping the next weapon above, then below
	if next_above != _cur_slot:
		_cur_slot = next_above
		weapon_changed.emit()
	elif next_below != _cur_slot:
		_cur_slot = next_below
		weapon_changed.emit()
	# if the inventory is empty, set the current slot to 0
	else:
		_cur_slot = 0
