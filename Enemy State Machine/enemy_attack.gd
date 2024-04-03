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
		#enemy.has_attacked = true
		#anim_player.play("Rat_Attack")
		timer = enemy.attack_cooldown
	else:
		timer -= delta
	
	#if enemy.should_wander():
		#transitioned.emit(self, "wander")
	
	if not enemy.should_attack():
		transitioned.emit(self, "follow")

