class_name EnemyFactory
extends Node
## Factory for building Enemies from EnemySpecs
##
## Build function will generate enemies from the supplied spec
## Negative or impossible spec values result in the enemy using default values


static func build(spec: EnemySpec) -> Enemy:
	var enemy_scene: Resource
	var enemy: Enemy
	match spec.type:
		EnemySpec.Type.BACTERIA:
			enemy_scene = load("res://scenes/enemies/shooter.tscn")
		EnemySpec.Type.VIRUS:
			enemy_scene = load("res://scenes/enemies/turret.tscn")
		EnemySpec.Type.PARASITE:
			enemy_scene = load("res://scenes/enemies/biter.tscn")
		_:
			enemy_scene = load("res://scenes/enemies/test_enemy.tscn")
	enemy = enemy_scene.instantiate() as Enemy
	enemy.weapon_drops = spec.weapon_drops
	if spec.max_health > 0.0:
		enemy.max_health = spec.max_health
	if spec.health_drop_chance >= 0.0 and spec.health_drop_chance <= 1.0:
		enemy.health_drop_chance = spec.health_drop_chance
	return enemy
