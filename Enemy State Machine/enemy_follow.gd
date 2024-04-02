extends State
class_name EnemyFollow

#@onready var player: Player = Global.player
@onready var enemy: CharacterBody3D = $"../.."

func enter():
	print("enter follow")

func update(_delta):
	pass

func physics_update(_delta):
	enemy.follow()
	
	if not enemy.should_follow():
		transitioned.emit(self, "idle")
