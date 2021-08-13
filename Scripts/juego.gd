extends Node2D

export(PackedScene) var frutas
var frutas_texts = load("res://fruta_frames.tres")

onready var UI = $CanvasLayer/UI

var timer_start : int
var time_passed : int
var max_time : int = 100000

var puntos : int = 0
var idx = -1
var current_fruta : int
var max_numbers : int = 0
var numbers : Array = []

var over : bool = false

func _ready():
	randomize()
	time_passed = max_time
	max_numbers = frutas_texts.get_frame_count("default")
	
	for i in max_numbers:
		numbers.append(i)
	numbers.shuffle()
	
	set_current_fruta()
	
	timer_start = OS.get_ticks_msec()

func set_current_fruta():
	current_fruta = randi() % max_numbers
	get_tree().call_group("fruta","set_outline", current_fruta)
	UI.get_node("fruta_text").set_texture(frutas_texts.get_frame("default", current_fruta))

func _physics_process(delta):
	UI.get_node("Label").set_text(str(puntos))
	UI.get_node("Label2").set_text("current fruta: %d" % current_fruta)
	
	if time_passed > 0 and !over:
		time_passed = (max_time - (OS.get_ticks_msec() - timer_start)) / 1000
		UI.get_node("time_label").set_text(str(time_passed))
	else:
		check_puntos()
		over = true

func check_puntos():
	$fruta_spawner.stop()
	if puntos > 0:
		UI.get_node("you_win_or_lose").set_text("YOU WIN!")
	else:
		UI.get_node("you_win_or_lose").set_text("YOU LOSE!")

func fruta_clickada(fruta_):
	if !over:
		if fruta_ == current_fruta:
			puntos += 100
			set_current_fruta()
		else:
			puntos -= 100

func _on_fruta_spawner_timeout():
	var f = frutas.instance()
	idx = wrapi(idx + 1, 0, max_numbers)
	f.set_number(numbers[idx])
	f.set_outline(current_fruta)
	
	var left = randi() % 2
	f.position = $spawn_point.position + Vector2.RIGHT * 1150 * left
	f.from_left = bool(left)
	f.connect("tipo_fruta", self, "fruta_clickada", [], CONNECT_ONESHOT)
	add_child(f)
	
	if idx == max_numbers - 1:
		prints(numbers, numbers[idx])
		numbers.shuffle()

func _on_pause_pressed():
	get_tree().set_pause(true)
	$CanvasLayer/pause.hide()
	$CanvasLayer/menu_pausa.show()

func _on_resume_pressed():
	if get_tree().is_paused():
		get_tree().set_pause(false)
		$CanvasLayer/pause.show()
		$CanvasLayer/menu_pausa.hide()

func _on_restart_pressed():
	get_tree().set_pause(false)
	get_tree().reload_current_scene()
