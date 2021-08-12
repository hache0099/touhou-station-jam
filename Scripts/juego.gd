extends Node2D

export(PackedScene) var frutas

var timer_start : int
var time_passed : int
var max_time : int = 10000

var puntos : int = 0
var idx = -1
var current_fruta : int
var max_numbers : int = 7
var numbers : Array = []

func _ready():
	randomize()
	time_passed = max_time
	
	current_fruta = randi() % max_numbers
	for i in max_numbers:
		numbers.append(i)
	numbers.shuffle()
	
	timer_start = OS.get_ticks_msec()

func _process(delta):
	$Label.set_text(str(puntos))
	$Label2.set_text("current fruta: %d" % current_fruta)
	
	if time_passed > 0:
		time_passed = (max_time - (OS.get_ticks_msec() - timer_start)) / 1000
		$time_label.set_text(str(time_passed))

func fruta_clickada(fruta_):
	if fruta_ == current_fruta:
		puntos += 100
		current_fruta = randi() % max_numbers
	else:
		puntos -= 100

func _on_fruta_spawner_timeout():
	var f = frutas.instance()
	idx = wrapi(idx + 1, 0, max_numbers)
	f.number = numbers[idx]
	
	var left = randi() % 2
	f.position = $spawn_point.position + Vector2.RIGHT * 1100 * left
	f.from_left = bool(left)
	f.connect("tipo_fruta", self, "fruta_clickada", [], CONNECT_ONESHOT)
	add_child(f)
	
	if idx == max_numbers - 1:
		numbers.shuffle()
