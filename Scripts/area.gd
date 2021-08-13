extends RigidBody2D

signal tipo_fruta(fruta_)

var current_number : int
var number : int = 0 setget set_number

var colors = ["red", "green", "blue", "blueviolet", "orange", "yellow", "black"]

var min_angle : float = 25.0
var max_angle : float = 45.0

var min_force : float = 500.0
var max_force : float = 700.0

var click_rect : Rect2

var angle : float
var force : float

var from_left : bool = true

func _ready():
	$click_detecter.set_as_toplevel(true)
	click_rect.size = Vector2(36*2,38*2)

func _physics_process(delta):
	click_rect.position = position - Vector2(36,38)
	click()
	$Label.set_text(str(number))
#	$Sprite.modulate = ColorN(colors[number])
	$click_detecter.position = position

func click():
	if Input.is_action_just_pressed("mouse"):
		if click_rect.has_point(get_global_mouse_position()):
			sleeping = true
			if number == current_number:
				$CPUParticles2D.set_texture(load("res://star.png"))
			else:
				$CPUParticles2D.set_texture(load("res://cross_red.png"))
			emit_signal("tipo_fruta",number)

func set_number(num : int):
	number = num
	$AnimatedSprite.frame = num

func set_outline(current_fruta):
	if current_fruta == number:
		$AnimatedSprite.set_material(load("res://outline_material.tres"))
	else:
		$AnimatedSprite.set_material(null)

#func _input(event):
#	if event is InputEventMouseButton:
#		if event.is_pressed() and event.button_index == BUTTON_LEFT:
#			if click_rect.has_point(get_global_mouse_position()):
#				sleeping = true
#				print("mouse click" + colors[number])
#				yield(get_tree().create_timer(0.5),"timeout")
#				queue_free()

func launch():
	angle = rand_range(min_angle, max_angle)
	
	var angle_range = max_angle - min_angle
	var new_max = max_force - 90 * ((angle - min_angle) / angle_range)
	force = rand_range(min_force, new_max)
	
	var new_angle = 180 * float(from_left) - (angle)
	
	apply_impulse(Vector2(rand_range(-5,5),rand_range(-5,5)), polar2cartesian(force, deg2rad(-abs(new_angle))))

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Timer_timeout():
	launch()

#func _on_click_detecter_input_event(viewport, event, shape_idx):
#	if event is InputEventMouseButton:
#		if event.is_pressed() and event.button_index == BUTTON_LEFT:
#			sleeping = true
#			print("mouse click" + colors[number])
#			yield(get_tree().create_timer(0.5),"timeout")
#			queue_free()

#func _on_Button_pressed():
#	sleeping = true
#	print("mouse click" + colors[number])
#	yield(get_tree().create_timer(0.5),"timeout")
#	queue_free()
