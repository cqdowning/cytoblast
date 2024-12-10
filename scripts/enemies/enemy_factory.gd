class_name EnemyFactory
extends Node


static func build(spec:EnemySpec):
	var enemy_scene
	var enemy
	match spec.type:
		EnemySpec.Type.BACTERIA:
			enemy_scene = load("res://scenes/enemies/shooter.tscn")
		_:
			enemy_scene = load("res://scenes/enemies/test_enemy.tscn")
	enemy = enemy_scene.instantiate() as Enemy
	enemy.weapon_drops = spec.weapon_drops
	return enemy
