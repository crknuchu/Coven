extends State
class_name EnemyAttack

@onready var enemy: CharacterBody3D = $"../.."
@onready var player: Player = Global.player
@onready var timer: float = enemy.attack_cooldown
@onready var anim_player: AnimationPlayer = $"../../model/AnimationPlayer"

func enter():
	print("enter attack")

func update(_delta):
	pass

func physics_update(delta):
	if timer <= 0:
		player.hit(enemy.damage)
		anim_player.play("Eat")
		timer = enemy.attack_cooldown
	else:
		timer -= delta
	
	if not enemy.should_attack():
		transitioned.emit(self, "follow")

