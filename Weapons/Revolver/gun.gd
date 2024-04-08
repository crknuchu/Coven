extends Node3D

@onready var r = $RayCast3D
@export var damage: int = 50
@export var max_ammo: int = 50

@export var ammo: int = 20

#func _ready():
		#print(ammo)

func shoot():
	if ammo >= 1:
		if r.is_colliding():
			var enemy = r.get_collider()
			enemy.hit(damage)
		ammo -= 1
		print(ammo)

func add_ammo(ammount: int):
	ammo = minf(ammo + ammount, max_ammo)
			
