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
	target_pos = Vector3(randf_range(-10, 10), 0, randf_range(-10, 10))
	#await get_tree().create_timer(enemy.wander_cooldown).timeout

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

