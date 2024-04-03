extends State
class_name EnemyIdle

@onready var enemy: CharacterBody3D = $"../.."
@onready var anim_player: AnimationPlayer = $"../../Rat2/AnimationPlayer"

func enter():
	print("enter idle")

func update(_delta):
	pass

func physics_update(_delta):
	#anim_player.play("Rat_Idle")
	
	if enemy.should_follow():
		transitioned.emit(self, "follow")