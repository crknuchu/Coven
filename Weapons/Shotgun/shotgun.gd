extends Node3D

@export var damage: float = 20
@export var spread: float = 5

@onready var container = $container

func _ready():
	randomize()
	for r in container.get_children():
		r.target_position.x = randf_range(spread, -spread)
		r.target_position.y = randf_range(spread, -spread)

func fire():
	for r in container.get_children():
		r.target_position.x = randf_range(spread, -spread)
		r.target_position.y = randf_range(spread, -spread)
		if r.is_colliding():
			var enemy = r.get_collider()
			enemy.hit(damage)
