extends Node3D

@onready var door = $Interactable

func _ready():
	door.interacted.connect(on_door_interacted)

func on_door_interacted():
	if Global.player.has_red_key:
		print("interact with red door")
	else:
		print("you dont have red key")
