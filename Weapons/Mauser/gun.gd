extends Node3D

@onready var r = $RayCast3D
@export var damage = 50

func fire():
	if r.is_colliding():
		var enemy = r.get_collider()
		enemy.hit(damage)
		
