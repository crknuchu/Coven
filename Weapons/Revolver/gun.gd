extends Node3D

@onready var r = $RayCast3D
@export var damage: float = 50
@export var max_ammo: float = 50

@export var ammo: float = 20
@onready var can_shoot: bool = true
@export var shoot_timer: float = 1.5
@onready var bullet_decal = preload("res://Weapons/bullet_decal.tscn")

func shoot():
	if ammo >= 1 and can_shoot:
		if r.is_colliding():
			var body = r.get_collider()
			if body is Enemy:
				body.hit(damage)
			else:
				add_bullet_decal()
		ammo -= 1
		can_shoot = false
		await get_tree().create_timer(shoot_timer).timeout
		can_shoot = true
		print(ammo)

func add_ammo(ammount: float):
	ammo = minf(ammo + ammount, max_ammo)

func add_bullet_decal():
	var b = bullet_decal.instantiate()
	r.get_collider().add_child(b)
	b.global_transform.origin = r.get_collision_point()
	if r.get_collision_normal() != Vector3.UP:
		b.look_at(r.get_collision_point() + r.get_collision_normal(), Vector3.UP)
	else:
		b.look_at(r.get_collision_point() + r.get_collision_normal(), Vector3.RIGHT)
			
