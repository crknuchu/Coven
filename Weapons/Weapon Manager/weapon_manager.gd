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
	#pass

func add_ammo(type: String, ammount: int):
	if type == "shotgun":
		weapons[2].add_ammo(ammount)
	if type == "revolver":
		weapons[2].add_ammo(ammount)

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
		
	
