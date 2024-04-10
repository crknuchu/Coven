extends  Enemy

@onready var attack_hitbox: Area3D = $"Attack Hitbox"
@onready var attack_hitbox2: Area3D = $"Attack Hitbox2"

func _ready():
	#wait 1 frame so the map can load and avoid errors
	set_physics_process(false)
	call_deferred('setup')
	
func setup():
	await get_tree().physics_frame
	set_physics_process(true)
	nav_agent.set_target_position(Global.player.global_position)

func draw_follow_range_sphere():
	if draw_follow_range:
		DebugDraw3D.draw_sphere(position,follow_range,Color(0,1,0))

func draw_attack_range_sphere():
	if draw_attack_range:
		DebugDraw3D.draw_sphere(position,attack_range,Color(1,0,0))

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
	
func should_attack():
	#return global_position.distance_to(Global.player.global_position) < attack_range \
		#and vision_raycast.is_colliding() \
		#and vision_raycast.get_collider() is Player
	for body in attack_hitbox2.get_overlapping_bodies():
		if body is Player:
			return true
	return false

func should_wander():
	return has_attacked
	
func attack():
	has_attacked = true
	for body in attack_hitbox.get_overlapping_bodies():
		if body is Player:
			body.hit(damage)
