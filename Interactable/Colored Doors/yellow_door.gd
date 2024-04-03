extends Node3D

@onready var door = $Interactable

func _ready():
	door.interacted.connect(on_door_interacted)

func on_door_interacted():
	if Global.player.has_yellow_key:
		print("interact with yellow door")
	else:
		print("you dont have yellow key")
