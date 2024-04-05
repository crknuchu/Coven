extends State
class_name EnemyAttack

@onready var enemy: CharacterBody3D = $"../.."
@onready var player: Player = Global.player
@onready var timer: float = enemy.attack_cooldown
@onready var anim_player: AnimationPlayer = $"../../Rat2/AnimationPlayer"

func enter():
	print("enter attack")
	await get_tree().create_timer(enemy.attack_cooldown).timeout 
	enemy.attack()

func update(_delta):
	pass

func physics_update(_delta):
	if enemy.should_wander():
		transitioned.emit(self, "wander")
	
	if not enemy.should_attack():
		transitioned.emit(self, "follow")

