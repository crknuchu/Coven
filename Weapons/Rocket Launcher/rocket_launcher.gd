extends Node3D

@onready var rocket = preload("res://Weapons/Rocket Launcher/rocket.tscn")
@export var ammo: float = 20
@export var shoot_timer: float = 1.5
@onready var can_shoot: bool = true

func shoot():
	if ammo >= 1 and can_shoot:
		var instance = rocket.instantiate()
		instance.position = global_position
		instance.transform.basis = global_transform.basis
		get_tree().current_scene.add_child(instance)
		ammo -= 1
		can_shoot = false
		await get_tree().create_timer(shoot_timer).timeout
		can_shoot = true
	print(ammo)
		
