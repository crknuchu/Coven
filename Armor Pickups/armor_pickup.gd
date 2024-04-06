extends Node3D

@export var ammout: int

@onready var hitbox = $Area3D

func _physics_process(_delta):
	for body in hitbox.get_overlapping_bodies():
		if body is Player:
			Global.player.get_armor(ammout)
			queue_free()
