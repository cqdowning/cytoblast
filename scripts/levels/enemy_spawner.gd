class_name EnemySpawner
extends Node2D

@export var enemy_specs: Array[EnemySpec]
@export var wave_delay: float
@export var initial_delay: float

var active = false

var _spec_index: int
var _timer: Timer
var _bacteria_particle: Texture2D = load("res://assets/weapons/bullets/bullet_antibacterial.png")
var _virus_particle: Texture2D = load("res://assets/weapons/bullets/bullet_antiviral.png")
var _parasite_particle: Texture2D = load("res://assets/weapons/bullets/bullet_antiparasitic.png")

@onready var particles: GPUParticles2D = $GPUParticles2D 

func _ready() -> void:
	_spec_index = 0
	_timer = Timer.new()
	add_child(_timer)
	_timer.one_shot = true
	_timer.timeout.connect(_on_timeout)
	_update_particle()
	

func _process(_delta):
	if _timer.time_left < 1.0 and _timer.time_left > 0.0 and _spec_index < enemy_specs.size():
		particles.emitting = true
	else:
		particles.emitting = false


func start_timer() -> void:
	_timer.start(initial_delay)


func _on_timeout() -> void:
	if _spec_index < enemy_specs.size():
		var enemy = EnemyFactory.build(enemy_specs[_spec_index])
		enemy.target = $"../Player"
		# add code here for making random enemies?
		add_child(enemy)
		audio_manager.play_enemy_spawn()
		_timer.start(wave_delay)
		_spec_index += 1
		_update_particle()


func _update_particle() -> void:
	if _spec_index >= enemy_specs.size():
		return
	match enemy_specs[_spec_index].type:
		EnemySpec.Type.BACTERIA:
			particles.texture = _bacteria_particle
		EnemySpec.Type.VIRUS:
			particles.texture = _virus_particle
		EnemySpec.Type.PARASITE:
			particles.texture = _parasite_particle
		_:
			particles.texture = _bacteria_particle
	
