extends Node3D

@export var speed: float = 1.0
@export var damage: float = 10
@onready var player_pos: Vector3 = Global.player.position
@onready var ray: RayCast3D = $RayCast3D

func _physics_process(delta):
	position += transform.basis * Vector3(0,0,speed) * delta
	
	if ray.is_colliding():
		if ray.get_collider() is Player:
			Global.player.hit(damage)
			queue_free()
		else:
			queue_free()
