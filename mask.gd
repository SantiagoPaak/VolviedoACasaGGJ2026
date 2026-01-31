extends Node3D

# Variables de estado y ángulos
var is_equipped = false
var open_angle = 90.0
var close_angle = 0.0

@export var velocity = 8.0
@export var cooldown = 1.0

var target: float

func _ready():
	# Inicializamos el objetivo en posición abierta
	target = open_angle 

func _input(event):
	#Tecla M
	if event.is_action_pressed("put_mask") and cooldown >= 1.0:
		cooldown = 0.0
		is_equipped = !is_equipped
		target = close_angle if is_equipped else open_angle
		

func _process(delta):
	cooldown += delta
	
	if rotation_degrees.x == target: return
	
	# Interpolación suave de la rotación
	var target_rad = deg_to_rad(target)
	rotation.x = lerp_angle(rotation.x, target_rad, velocity * delta)
	# Ajuste final para evitar micro-movimientos infinitos
	if abs(rotation_degrees.x - target) < 0.1:
		rotation_degrees.x = target
	
	
	
	
	
