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
@onready var hitbox = $Camera3D/Knife/Hitbox
@onready var ui_health: Label = $HUD/health_val
@onready var ui_armor: Label = $HUD/armor_val
@onready var gun = $Camera3D/Gun
@onready var shotgun = $Camera3D/Shotgun

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Global.player = self
	update_health_armor()
	
func _physics_process(delta):
	_process_movement(delta)
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
	var damage = 50
	if Input.is_action_just_pressed("attack"):
		#attack(damage)
		shoot(damage)

func shoot(_damage):
	print("shoot")
	gun.fire()
	#gun.shoot(damage)

func attack(damage):
	for enemy in hitbox.get_overlapping_bodies():
		enemy.hit(damage)

func hit(damage):
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
	health = maxf(health + ammount, max_health)
	update_health_armor()

func get_armor(ammount):
	armor = maxf(armor + ammount, max_armor)
	update_health_armor()

func is_dead():
	return health <= 0

func die():
	print("you died")

func update_health_armor():
	ui_health.text = str(health)
	ui_armor.text = str(armor)
