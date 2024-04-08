extends Node3D

@onready var r = $RayCast3D
@export var damage = 50

func shoot():
	if r.is_colliding():
		var enemy = r.get_collider()
		enemy.hit(damage)
		
