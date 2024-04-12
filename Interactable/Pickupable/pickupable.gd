extends Node3D
class_name Pickupable

@onready var pickupable = $Interactable
@onready var picked_up: bool = false
@export var throw_speed: float = 10

func _ready():
	pickupable.interacted.connect(on_pickupable_interacted)

func on_pickupable_interacted():
	if not picked_up:
		pick_up()
	else:
		throw()

func pick_up():
	print("pick up")
	pickupable.set_freeze_enabled(true)
	pickupable.global_position = Global.player.hold_position.global_position
	reparent(Global.player.hold_position)
	picked_up = true

func throw():
	print("throw")
	reparent(get_tree().current_scene)
	pickupable.set_freeze_enabled(false)
	pickupable.apply_impulse(Global.player.camera.get_global_transform().basis.z * -throw_speed)
	picked_up = false
