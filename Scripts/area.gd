extends RigidBody2D

var min_angle : float = 25.0
var max_angle : float = 45.0

var min_force : float = 500.0
var max_force : float = 700.0

var start_position : Vector2 setget set_start_position

var angle : float
var force : float

var from_left : bool = true

func _ready():
	yield(get_tree().create_timer(0.5),"timeout")
	launch()

func set_start_position(pos : Vector2):
	start_position = pos

func launch():
	angle = rand_range(min_angle, max_angle)
	force = rand_range(min_force, max_force)
	
	var new_angle = 180 * float(from_left) - (angle * pow(-1,float(!from_left)))
	
	apply_impulse(Vector2(1,0), polar2cartesian(force, deg2rad(-new_angle)))
	prints(angle, new_angle)

func _on_VisibilityNotifier2D_screen_exited():
	#Reinicia la posicion del RigidBody
	position = Vector2(-63,330)
	sleeping = true
