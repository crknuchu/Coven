extends Node3D
class_name Interactable

signal interacted

func on_interact(_player: Player):
	interacted.emit()
