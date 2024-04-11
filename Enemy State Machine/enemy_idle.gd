extends State
class_name EnemyIdle

@onready var enemy: CharacterBody3D = $"../.."

func enter():
	print("enter idle")

func update(_delta):
	pass

func physics_update(_delta):
	if enemy.should_follow():
		transitioned.emit(self, "follow")
	#pass

func exit():
	print("exit idle")
