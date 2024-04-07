extends CharacterBody3D

@export var speed: float = 1.0
@export var damage: float = 10
@onready var player_pos: Vector3 = Global.player.position
@onready var area = $Area3D


func _ready():
	velocity = (player_pos * Vector3(1,1,10) - global_position).normalized() * speed

func _physics_process(delta):
	for body in area.get_overlapping_bodies():
		if body is Player:
			Global.player.hit(damage)
			queue_free()
		else:
			#print("hit wall")
			queue_free()
	move_and_slide()
