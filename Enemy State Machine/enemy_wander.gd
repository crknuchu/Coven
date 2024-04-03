extends State
class_name EnemyWander

@onready var enemy: CharacterBody3D = $"../.."
@onready var player: Player = Global.player
@onready var anim_player: AnimationPlayer = $"../../Rat2/AnimationPlayer"

func enter():
	print("enter wander")

func update(_delta):
	pass

func physics_update(delta):
	enemy.wander()
	#anim_player.play("Walk")
	await get_tree().create_timer(enemy.wander_cooldown).timeout 
	
	if enemy.should_attack():
		enemy.has_attacked = false
		transitioned.emit(self, "attack")
	
	if not enemy.should_attack():
		transitioned.emit(self,"follow")

