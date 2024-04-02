extends Node3D

@onready var aimcast = get_parent().get_node("AimCast")

func shoot(damage):
	if aimcast.is_colliding():
		var enemy = aimcast.get_collider()
		enemy.hit(damage)
		
