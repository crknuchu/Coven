extends Node3D

signal secret_found

@onready var hitbox = $Area3D

func _physics_process(_delta):
	for body in hitbox.get_overlapping_bodies():
		if body is Player:
			secret_found.emit()
			queue_free()
