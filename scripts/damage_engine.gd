class_name DamageEngine
extends Node
## Damage calculator
##
## Contains static function for calculating the 
## damage multiplier to be applied to an enemy

static func damage_multiplier(projectile: Projectile, enemy: Enemy) -> float:
	if projectile.type == Weapon.Type.ANTIBIOTIC:
		if enemy.type == Enemy.Type.BACTERIA:
			return 1.5
		elif enemy.type == Enemy.Type.VIRUS:
			return 0.75
		elif enemy.type == Enemy.Type.PARASITE:
			return 1.0
	elif projectile.type == Weapon.Type.ANTIVIRAL:
		if enemy.type == Enemy.Type.BACTERIA:
			return 1.0
		elif enemy.type == Enemy.Type.VIRUS:
			return 1.5
		elif enemy.type == Enemy.Type.PARASITE:
			return 0.75
	elif projectile.type == Weapon.Type.ANTIPARASITIC:
		if enemy.type == Enemy.Type.BACTERIA:
			return 0.75
		elif enemy.type == Enemy.Type.VIRUS:
			return 1.0
		elif enemy.type == Enemy.Type.PARASITE:
			return 1.5
			
	# return 1.0 if either type is NONE	
	return 1.0
	
