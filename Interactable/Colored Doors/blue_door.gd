extends Node3D

@onready var door = $Interactable

func _ready():
	door.interacted.connect(on_door_interacted)

func on_door_interacted():
	if Global.player.has_blue_key:
		print("interact with blue door")
	else:
		print("you dont have blue key")
