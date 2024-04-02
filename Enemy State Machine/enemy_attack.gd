extends State
class_name EnemyAttack

@onready var enemy: CharacterBody3D = $"../.."
@onready var player: Player = Global.player
var timer: float = 0.0

func enter():
	print("enter attack")

func update(_delta):
	pass

func physics_update(delta):
	if timer <= 0:
		player.hit(enemy.damage)
		timer = enemy.attack_cooldown
	else:
		timer -= delta
	
	if not enemy.should_attack():
		transitioned.emit(self, "follow")

