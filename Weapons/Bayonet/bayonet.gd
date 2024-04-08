extends Node3D

@export var damage: float = 50
@onready var hitbox = $Hitbox

func shoot():
	for enemy in hitbox.get_overlapping_bodies():
			enemy.hit(damage)
