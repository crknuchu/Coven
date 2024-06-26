class_name Player
extends CharacterBody3D

@export var movement_speed: float = 3.5
@export var sensitivity: float = 0.6
@export var max_health: float = 100.0
@export var max_armor: float = 100.0
@export var jump_velocity: float = 6.5
@export var gravity: float = 10.0

@onready var camera: Camera3D = $Camera3D
@onready var health: float = max_health
@onready var armor: float = max_armor
#@onready var knife = $Camera3D/Knife
@onready var ui_health: Label = $HUD/health_val
@onready var ui_armor: Label = $HUD/armor_val
#@onready var gun = $Camera3D/Gun
#@onready var shotgun = $Camera3D/Shotgun
@onready var interact_raycast: RayCast3D = $Camera3D/RayCast3D
@onready var weapon_manager: Node3D = $"Camera3D/Weapon Manager"
@onready var hold_position = $"Camera3D/Hold Position"

var has_red_key: bool = false
var has_blue_key: bool = false
var has_yellow_key: bool = false

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Global.player = self
	update_health_armor()
	
func _physics_process(delta):
	_process_movement(delta)
	_process_interacting()
	_process_input()

func _process_movement(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
		
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var v1 = Vector2(velocity.x, velocity.z)
	var v2 = Vector2(direction.x, direction.z) * movement_speed
	var v3 = lerp(v1, v2, 8.0*delta)
	velocity = Vector3(v3.x, velocity.y, v3.y)
	
	move_and_slide()

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		camera.rotate_x(-sensitivity*event.relative.y/100.0)
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -90, 90)
		rotate_y(-sensitivity*event.relative.x/100.0)

func _process_input():
	if Input.is_action_just_pressed("attack"):
		shoot()

func shoot():
	weapon_manager.shoot()

func hit(damage):
	print("get hit")
	if(armor > 0):
		if(armor > damage):
			armor -= damage
		else:
			health -= damage - armor
			armor = 0
	else:
		health -= damage
	update_health_armor()
	if is_dead():
		die()

func heal(ammount):
	health = minf(health + ammount, max_health)
	update_health_armor()
	print("heal for " + str(ammount))

func get_armor(ammount):
	armor = minf(armor + ammount, max_armor)
	update_health_armor()
	print("get armor for " + str(ammount))

func is_dead():
	return health <= 0

func die():
	print("you died")

func update_health_armor():
	ui_health.text = str(health)
	ui_armor.text = str(armor)

func interact():
	var interactable: Interactable = interact_raycast.get_collider()
	interactable.on_interact(self)

func _process_interacting():
	#interact_label.visible = interact_raycast.is_colliding() and interact_raycast.get_collider() is Interactable
	if Input.is_action_just_pressed("interact") and interact_raycast.is_colliding() and interact_raycast.get_collider() is Interactable:
		interact()
