extends Node3D

@onready var door = $Interactable

func _ready():
	door.interacted.connect(on_door_interacted)

func on_door_interacted():
	print("interact with door")

