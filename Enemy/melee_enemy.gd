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
	
func should_attack(): 
	#return global_position.distance_to(Global.player.global_position) < attack_range \
		#and vision_raycast.is_colliding() \
		#and vision_raycast.get_collider() is Player
	for body in attack_hitbox2.get_overlapping_bodies():
		if body is Player:
			return true
	return false
	
func attack():
	for body in attack_hitbox.get_overlapping_bodies():
		if body is Player:
			body.hit(damage)
