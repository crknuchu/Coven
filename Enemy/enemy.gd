extends CharacterBody3D

@export var max_health: float = 100.0
@export var damage: float = 20.0

@onready var health: float = max_health

func hit(damage):
	print("enemy hit")
	health-=damage
	if is_gibbed(): #gib logic
		gib()
	elif is_dead():
		die()
	
func die():
	print("enemy died")
	queue_free()

func gib():
	print("enemy gibbed")
	queue_free()

func is_gibbed():
	return health <= -max_health

func is_dead():
	return health <= 0
