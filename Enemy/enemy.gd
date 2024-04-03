extends CharacterBody3D
class_name Enemy

@export var max_health: float = 100.0
@export var damage: float = 20.0
@export var speed: float = 5.0
@export var follow_range: float = 5.0
@export var attack_range: float = 3.0
@export var attack_cooldown: float = 3.0
@export var wander_cooldown: float = 3.0
@export var draw_follow_range: bool = false
@export var draw_attack_range: bool = false
@onready var has_attacked: bool = false

@onready var attack_hitbox: Area3D = $"Attack Hitbox"
@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@onready var vision_raycast: RayCast3D = $RayCast3D
@onready var health: float = max_health

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

func send_raycast():
	vision_raycast.rotation.y = -rotation.y
	vision_raycast.target_position = (Global.player.global_position + Vector3.UP*0.5 - vision_raycast.global_position)

func follow():
	nav_agent.set_target_position(Global.player.global_position)
	var next_nav_point = nav_agent.get_next_path_position()
	velocity = (next_nav_point - global_position).normalized() * speed
	
	rotation.y = -Vector2(global_position.x, global_position.z) \
		.angle_to_point(Vector2(Global.player.global_position.x, Global.player.global_position.z)) + PI/2.0
	
	move_and_slide()

func wander():
	var target_pos = Vector3(100, 0, 100)
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

func should_wander():
	return has_attacked

func hit(player_damage):
	print("enemy hit")
	health -= player_damage
	if is_gibbed(): #gib logic
		gib()
	elif is_dead():
		die()
	
func die():
	print("enemy died")
	queue_free()

func gib():
	print("enemy gibbed")
	queue_free()

func is_gibbed():
	return health <= -max_health

func is_dead():
	return health <= 0
	
func attack():
	for body in attack_hitbox.get_overlapping_bodies():
		if body is Player:
			body.hit(damage)
