extends CharacterBody3D
class_name Enemy

@export var max_health: float = 100.0
@export var damage: float = 20.0
@export var speed: float = 5.0
@export var follow_range: float = 5

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

func draw_follow_range():
	DebugDraw3D.draw_sphere(position,follow_range,Color(1,0,0))

func _physics_process(_delta):
	if not is_instance_valid(Global.player):
		return
	if should_follow():
		follow()
	send_raycast()
	draw_follow_range()

func send_raycast():
	vision_raycast.rotation.y = -rotation.y
	vision_raycast.target_position = (Global.player.global_position + Vector3.UP*0.5 - vision_raycast.global_position) *100

func follow():
	nav_agent.set_target_position(Global.player.global_position)
	var next_nav_point = nav_agent.get_next_path_position()
	velocity = (next_nav_point - global_position).normalized() * speed
	
	rotation.y = -Vector2(global_position.x, global_position.z) \
		.angle_to_point(Vector2(Global.player.global_position.x, Global.player.global_position.z)) + PI/2.0
	
	move_and_slide()

func should_follow():
	return global_position.distance_to(Global.player.global_position) < follow_range \
		and vision_raycast.is_colliding() \
		and vision_raycast.get_collider() is Player

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
	Global.player.hit(damage)
