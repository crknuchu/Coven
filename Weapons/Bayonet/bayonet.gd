extends Node3D

@export var damage: float = 50
@onready var hitbox = $Hitbox
@export var shoot_timer: float = 1.5
@onready var can_shoot: bool = true

func shoot():
	if can_shoot:
		for enemy in hitbox.get_overlapping_bodies():
				enemy.hit(damage)
		can_shoot = false
		await get_tree().create_timer(shoot_timer).timeout
		can_shoot = true
			
