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

func _physics_process(_delta):
	if not is_instance_valid(Global.player):
		return
	send_raycast()
	draw_follow_range_sphere()
	draw_attack_range_sphere()

func wander(target_pos: Vector3):
	nav_agent.set_target_position(target_pos)
	var next_nav_point = nav_agent.get_next_path_position()
	velocity = (next_nav_point - global_position).normalized() * speed
	
	rotation.y = -Vector2(global_position.x, global_position.z) \
		.angle_to_point(Vector2(target_pos.x, target_pos.z)) + PI/2.0
	
	move_and_slide()

func should_follow():
	return global_position.distance_to(Global.player.global_position) < follow_range \
		and vision_raycast.is_colliding() \
		and vision_raycast.get_collider() is Player
	
func should_attack():
	return global_position.distance_to(Global.player.global_position) < attack_range \
		and vision_raycast.is_colliding() \
		and vision_raycast.get_collider() is Player
	#for body in attack_hitbox2.get_overlapping_bodies():
		#if body is Player:
			#return true
	#return false

func attack():
	print("attack")
	var instance = bullet.instantiate()
	instance.damage = damage
	instance.position = global_position
	instance.transform.basis = global_transform.basis
	get_parent().add_child(instance)
