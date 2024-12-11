class_name AudioManager
extends Node


func play_weapon_pickup():
	$WeaponPickup.play()

func play_weapon_switch():
	$WeaponSwitch.play()

func play_throw_weapon():
	$WeaponThrow.play()
	
func play_rifle_shoot():
	$RifleShoot.play()
	
func play_melee():
	$Melee.play()
