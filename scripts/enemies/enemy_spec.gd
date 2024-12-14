class_name EnemySpec
extends Resource
## Represents a specification for building an enemy using the Enemy Factory
##
## Negative or impossible values represent using default enemy values

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
