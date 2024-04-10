extends State
class_name EnemyAttack

@onready var enemy: CharacterBody3D = $"../.."
@onready var player: Player = Global.player
@onready var timer: float = enemy.attack_cooldown
@onready var anim_player: AnimationPlayer = $"../../Rat2/AnimationPlayer"

func enter():
	print("enter attack") 
	
func update(_delta):
	pass

func physics_update(delta):
	if timer <= 0:
		enemy.attack()
		timer = enemy.attack_cooldown
		transitioned.emit(self, "wander")
	else:
		timer -= delta
	
	if not enemy.should_attack():
		transitioned.emit(self, "follow")

func exit():
	print("exit attack")

