extends RigidBody2D

func _ready():
	randomize()
	$debug.set_as_toplevel(true)
	launch()

func launch():
	var angle : float = rand_range(25.0,45.0)
	var force : float = rand_range(500.0, 700.0)
	
	$debug.set_text(str("angulo: %.2f\nfuerza: %.2f" % [angle, force]))
	
	yield(get_tree().create_timer(0.5),"timeout")
	apply_impulse(Vector2(1,0), polar2cartesian(force, deg2rad(-angle)))

func _on_VisibilityNotifier2D_screen_exited():
	#Reinicia la posicion del RigidBody
	position = Vector2(-63,330)
	sleeping = true
	launch()
