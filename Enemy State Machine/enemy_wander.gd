extends State
class_name EnemyWander

@onready var enemy: Enemy = $"../.."
@onready var player: Player = Global.player
@onready var timer: float = enemy.wander_cooldown
@onready var anim_player: AnimationPlayer = $"../../Rat2/AnimationPlayer"
@onready var target_pos: Vector3

func enter():
	print("enter wander")
	randomize()
	
	var r = 10
	var theta = randf_range(0,360)
	target_pos = Vector3(enemy.position.x + r * cos(theta), 0, enemy.position.z + r * sin(theta))

func update(_delta):
	pass

func physics_update(delta):
	enemy.wander(target_pos)
	if timer <= 0:
		timer = enemy.wander_cooldown
		transitioned.emit(self, "attack")
	else:
		timer -= delta

func exit():
	print("exit wander")

