class_name AudioManager
extends Node


func play_weapon_pickup():
	$Weapons/WeaponPickup.play()

func play_weapon_switch():
	$Weapons/WeaponSwitch.play()

func play_throw_weapon():
	$Weapons/WeaponThrow.play()
	
func play_rifle_shoot():
	$Weapons/RifleShoot.play()
	
func play_shotgun_shoot():
	$Weapons/ShotgunShoot.play()
	
func play_machine_gun_shoot():
	$Weapons/MachineGunShoot.play()
	
func play_weapon_explosion():
	$Weapons/WeaponExplosion.play()
	
func play_melee():
	$Weapons/Melee.play()
	
func play_shooter_shoot():
	$Enemies/ShooterShoot.play()
	
func play_turret_shoot():
	$Enemies/TurretShoot.play()
	
func play_biter_attack():
	$Enemies/BiterAttack.play()
	
func play_enemy_hit_marker():
	$Enemies/EnemyHitMarker.play()
	
func play_room_entered():
	$Environment/RoomEntered.play()
	
func play_enemy_spawn():
	$Environment/EnemySpawn.play()
	
func play_player_hit_marker():
	$Player/PlayerHitMarker.play()
	
func play_player_dash():
	$Player/PlayerDash.play()
