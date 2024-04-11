extends Node3D

@onready var rocket = preload("res://Weapons/Rocket Launcher/rocket.tscn")
@export var ammo: float = 20

func shoot():
	if ammo >= 1:
		var instance = rocket.instantiate()
		instance.position = global_position
		instance.transform.basis = global_transform.basis
		get_tree().current_scene.add_child(instance)
		ammo -= 1
	print(ammo)
		
