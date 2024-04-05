extends State
class_name EnemyWander

@onready var enemy: CharacterBody3D = $"../.."
@onready var player: Player = Global.player
@onready var anim_player: AnimationPlayer = $"../../Rat2/AnimationPlayer"
@onready var target_pos: Vector3

func enter():
	print("enter wander")
	randomize()
	target_pos = Vector3(randf_range(-10, 10), 0, randf_range(-10, 10))

func update(_delta):
	pass

func physics_update(_delta):
	enemy.wander(target_pos)
	#anim_player.play("Walk")
	await get_tree().create_timer(enemy.wander_cooldown).timeout 
	
	if enemy.should_attack():
		enemy.has_attacked = false
		transitioned.emit(self, "attack")
	
	if not enemy.should_attack():
		transitioned.emit(self,"follow")

