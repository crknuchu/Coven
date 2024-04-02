extends CharacterBody3D

@export var max_health: float = 100.0
@export var damage: float = 20.0
@export var speed: float = 5.0
@onready var nav_agent = $NavigationAgent3D

@onready var health: float = max_health

func _physics_process(delta):
	follow()

func follow():
	nav_agent.set_target_position(Global.player.global_position)
	var next_nav_point = nav_agent.get_next_path_position()
	velocity = (next_nav_point - global_position).normalized() * speed
	
	rotation.y = -Vector2(global_position.x, global_position.z).angle_to_point(
		Vector2(Global.player.global_position.x, Global.player.global_position.z)
	) + PI/2.0
	
	move_and_slide()

func hit(damage):
	print("enemy hit")
	health-=damage
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
