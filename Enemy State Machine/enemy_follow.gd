extends State
class_name EnemyFollow

#@onready var player: Player = Global.player
@onready var enemy: CharacterBody3D = $"../.."
@onready var anim_player: AnimationPlayer = $"../../model/AnimationPlayer"

func enter():
	print("enter follow")

func update(_delta):
	pass

func physics_update(_delta):
	enemy.follow()
	anim_player.play("Walk")
	
	if not enemy.should_follow():
		transitioned.emit(self, "idle")
	
	if enemy.should_attack():
		transitioned.emit(self, "attack")
