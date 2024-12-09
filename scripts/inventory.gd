class_name Inventory
extends Node


@export var max_size = 3

var weapons:Array[Weapon]
var cur_slot = 0


func _ready() -> void:
	for i in range(0, max_size):
		weapons.push_back(null)
