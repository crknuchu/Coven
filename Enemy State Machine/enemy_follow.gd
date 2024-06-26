extends State
class_name EnemyFollow

@onready var enemy: CharacterBody3D = $"../.."
@onready var anim_player: AnimationPlayer = $"../../Rat2/AnimationPlayer"

func enter():
	print("enter follow")

func update(_delta):
	pass

func physics_update(_delta):
	if enemy.is_on_floor():
		enemy.follow()
		
	if enemy.should_attack():
		transitioned.emit(self, "attack")

func exit():
	print("exit follow")
