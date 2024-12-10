class_name EnemySpawner
extends Node2D

@export var enemy_specs:Array[EnemySpec]
@export var wave_delay:float
@export var initial_delay:float

var active = false

var _timer:Timer

@onready var particles: GPUParticles2D = $GPUParticles2D 

func _ready() -> void:
	_timer = Timer.new()
	add_child(_timer)
	_timer.one_shot = true
	_timer.timeout.connect(_on_timeout)
	
func _process(delta):
	if _timer.time_left < 1.0 && !enemy_specs.is_empty():
		particles.emitting = true
	else:
		particles.emitting = false


func start_timer():
	_timer.start(initial_delay)


func _on_timeout():
	var enemy_spec = enemy_specs.pop_front()
	if enemy_spec:
		var enemy = EnemyFactory.build(enemy_spec)
		enemy.target = $"../Player"
		# add code here for making random enemies?
		add_child(enemy)
		_timer.start(wave_delay)
