extends Node

@export var level_name: String
@export var difficulty: String


@export var par_time: int
@export var visible: bool = false

@onready var max_kills: int = 0
@onready var max_secrets: int = 0
@onready var secrets: int = 0
@onready var kills: int = 0
@onready var time: int = 0
@onready var enemies: Node3D = $"../Enemies"
@onready var level_text_label: Label = $"CanvasLayer/level text"
@onready var secrets_label: Label = $CanvasLayer/secrets
@onready var kills_label: Label =  $CanvasLayer/kills
@onready var canvas_layer = $CanvasLayer
@onready var secrets_items = $"../Secrets"

func _ready():
	for enemy in enemies.get_children():
		enemy.enemy_killed.connect(_update_kills)
		max_kills += 1
	
	for secret_item in secrets_items.get_children():
		secret_item.secret_found.connect(_update_secrets)
		max_secrets += 1
		
	update_kills_label()
	update_level_label()
	update_secrets_label()

func _update_secrets():
	secrets += 1
	update_secrets_label()

func _update_kills():
	kills += 1
	update_kills_label()

func update_kills_label():
	kills_label.text = str(kills) + " / " + str(max_kills)

func update_secrets_label():
	secrets_label.text = str(secrets) + " / " + str(max_secrets)

func update_level_label():
	level_text_label.text = str(level_name) + " - " + str(difficulty)

func _process(_delta):
	if Input.is_action_just_pressed("toggle_level_stats"):
		visible = !visible
	
	canvas_layer.visible = visible 
		
	
