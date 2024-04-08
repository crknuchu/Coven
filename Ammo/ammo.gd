extends Area3D

signal ammo_picked_up

@export var ammount: int = 10
@export var type: String = "shotgun"

func _physics_process(_delta):
	for body in get_overlapping_bodies():
		if body is Player:
			Global.player.weapon_manager.add_ammo(type,ammount)
			queue_free()
