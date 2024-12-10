class_name EnemySpawner
extends Node2D


@export var enemies:Array[PackedScene]
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
	if _timer.time_left < 1.0 && !_timer.is_stopped():
		particles.emitting = true
	else:
		particles.emitting = false


func start_timer():
	_timer.start(initial_delay)


func _on_timeout():
	var enemy_scene = enemies.pop_front()
	if enemy_scene:
		var enemy = enemy_scene.instantiate() as Enemy
		enemy.target = $"../Player"
		# add code here for making random enemies?
		add_child(enemy)
		_timer.start(wave_delay)
	
