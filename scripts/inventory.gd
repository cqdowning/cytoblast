class_name Inventory
extends Node


@export var max_size = 3

var weapons:Array[Weapon]
var rifle_ab = preload("res://scenes/weapons/weapon_antibiotic_rifle.tscn").instantiate() as Weapon
var rifle_av = preload("res://scenes/weapons/weapon_antiviral_rifle.tscn").instantiate() as Weapon
var rifle_ap = preload("res://scenes/weapons/weapon_antiparasitic_rifle.tscn").instantiate() as Weapon

var _cur_slot = 2


func _ready() -> void:
	weapons.push_back(rifle_ab)
	weapons.push_back(rifle_av)
	weapons.push_back(rifle_ap)
	print(is_empty())
		
		
func _process(delta: float) -> void:
	pass
		
		
func current_weapon():
	return weapons[_cur_slot]
	
		
func is_empty():
	for weapon in weapons:
		if weapon:
			return false
	return true
