class_name Player
extends CharacterBody3D

@export var movement_speed: float = 3.5
@export var sensitivity: float = 0.6
@export var max_health: float = 100.0

const JUMP_VELOCITY = 6.5
var gravity = 10.0

@onready var camera: Camera3D = $Camera3D
@onready var health: float = max_health

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _physics_process(delta):
	_process_movement(delta)
	_process_input()

func _process_movement(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	var input_dir = Input.get_vector(
		"move_left", "move_right", "move_forward", "move_backward"
		)
	
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var v1 = Vector2(velocity.x, velocity.z)
	var v2 = Vector2(direction.x, direction.z) * movement_speed
	var v3 = lerp(v1, v2, 8.0*delta)
	velocity = Vector3(v3.x, velocity.y, v3.y)
	
	move_and_slide()

func _process_input():
	pass