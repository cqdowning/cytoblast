class_name AudioManager
extends Node
## Audio Manager singleton for all game sounds
##
## This class is autoloaded as audio_manager


func play_weapon_pickup() -> void:
	$Weapons/WeaponPickup.play()


func play_weapon_switch() -> void:
	$Weapons/WeaponSwitch.play()


func play_throw_weapon() -> void:
	$Weapons/WeaponThrow.play()
	
	
func play_rifle_shoot() -> void:
	$Weapons/RifleShoot.play()
	
	
func play_shotgun_shoot() -> void:
	$Weapons/ShotgunShoot.play()
	
	
func play_machine_gun_shoot() -> void:
	$Weapons/MachineGunShoot.play()
	
	
func play_weapon_explosion() -> void:
	$Weapons/WeaponExplosion.play()
	
	
func play_melee() -> void:
	$Weapons/Melee.play()
	
	
func play_shoot_blank() -> void:
	$Weapons/ShootBlank.play()
	
	
func play_shooter_shoot() -> void:
	$Enemies/ShooterShoot.play()
	
	
func play_turret_shoot() -> void:
	$Enemies/TurretShoot.play()
	
	
func play_biter_attack() -> void:
	$Enemies/BiterAttack.play()
	
	
func play_enemy_hit_marker() -> void:
	$Enemies/EnemyHitMarker.play()
	
	
func play_room_entered() -> void:
	$Environment/RoomEntered.play()
	
	
func play_enemy_spawn() -> void:
	$Environment/EnemySpawn.play()
	
	
func play_door_open() -> void:
	$Environment/DoorOpen.play()
	
	
func is_playing_door_open() -> bool:
	return $Environment/DoorOpen.playing
	
	
func play_health_pickup() -> void:
	$Environment/HealthPickup.play()
	
	
func play_player_hit_marker() -> void:
	$Player/PlayerHitMarker.play()
	
	
func play_player_dash() -> void:
	$Player/PlayerDash.play()
