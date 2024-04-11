extends Node3D

@export var speed: float = 1.0
@export var damage: float = 10
@export var explosion_damage: float = 10
@onready var rocket_collision = $rocket_collision
@onready var explosion_collision = $explosion_collision

func _physics_process(delta):
	position += transform.basis * Vector3(0,0,speed) * delta
	
	for body in rocket_collision.get_overlapping_bodies():
		if body is Enemy:
			body.hit(damage)
			queue_free()
			explosion()
		else:
			explosion()
			queue_free()

func explosion():

	for body in explosion_collision.get_overlapping_bodies():
		if body is Enemy:
			print("explosion hit")
			body.hit(explosion_damage)
			var direction = body.position - position
			body.velocity += direction * 10
			#body.velocity += Vector3(0,1,0) * 10
			body.move_and_slide()
		elif body is Player:
			print("explosion hit")
			body.hit(explosion_damage/5.0)
			var direction = body.position - position
			body.velocity += direction * 10
		queue_free()
			
