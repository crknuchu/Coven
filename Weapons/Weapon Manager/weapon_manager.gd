extends Node3D

enum weapons_enum {
	BAYONET,
	SHOTGUN,
	REVOLVER
}

@onready var weapons = get_children()
@onready var current_weapon = weapons[0]

func _ready():
	print(weapons)
	#var tmp = {}
	#for weapon in weapons:
		

func shoot():
	current_weapon.shoot()

func _process(_delta):
	swap_weapons()
	

func swap_weapons():
	if Input.is_action_just_pressed("weapon_1"):
		current_weapon.visible = false
		current_weapon = weapons[0]
		current_weapon.visible = true
	elif Input.is_action_just_pressed("weapon_2"):
		current_weapon.visible = false
		current_weapon = weapons[1]
		current_weapon.visible = true
	elif Input.is_action_just_pressed("weapon_3"):
		current_weapon.visible = false
		current_weapon = weapons[2]
		current_weapon.visible = true
		
	
