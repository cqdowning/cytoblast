class_name EnemySpec
extends Resource


enum Type {
	BACTERIA,
	VIRUS,
	PARASITE,
	NONE,
}

@export var type: Type
@export var weapon_drops: Array[PackedScene]
@export var max_health: float = 0.0
@export var health_drop_chance: float = -1.0
