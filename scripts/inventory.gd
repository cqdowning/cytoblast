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
	weapons.push_back(rifle_ab)
	weapons.push_back(rifle_av)
	weapons.push_back(rifle_ap)
	
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
		
	if Input.is_action_just_pressed("prev_weapon"):
		var next_slot = _get_next_available_slot(-1)
		if next_slot == _cur_slot:
			return
		_cur_slot = next_slot
		weapon_changed.emit()
		
		
func current_weapon():
	return weapons[_cur_slot]
	
		
func is_empty():
	for weapon in weapons:
		if weapon:
			return false
	return true
	
	
func _get_next_available_slot(increment:int):
	var next_slot = _cur_slot + increment
	while next_slot < max_size and next_slot >= 0:
		if weapons[next_slot]:
			return next_slot
		next_slot = next_slot + increment
	return _cur_slot
		
