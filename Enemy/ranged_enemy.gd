extends Enemy

@onready var bullet = load("res://Enemy/bullet.tscn")

func _ready():
	#wait 1 frame so the map can load and avoid errors
	set_physics_process(false)
	call_deferred('setup')
	
func setup():
	await get_tree().physics_frame
	set_physics_process(true)
	nav_agent.set_target_position(Global.player.global_position)
	
func should_attack():
	return global_position.distance_to(Global.player.global_position) < attack_range \
		and vision_raycast.is_colliding() \
		and vision_raycast.get_collider() is Player

func attack():
	#print("attack")
	var instance = bullet.instantiate()
	instance.damage = damage
	instance.position = global_position
	instance.transform.basis = global_transform.basis
	get_parent().add_child(instance)
