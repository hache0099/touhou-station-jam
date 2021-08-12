extends Node2D

export(PackedScene) var frutas

var idx = -1
var max_numbers : int = 7
var numbers : Array = []

func _ready():
	randomize()
	
	for i in max_numbers:
		numbers.append(i)
	numbers.shuffle()

func _on_fruta_spawner_timeout():
	var f = frutas.instance()
	idx = wrapi(idx + 1, 0, max_numbers)
	f.number = numbers[idx]
	
	var left = randi() % 2
	f.position = $spawn_point.position + Vector2.RIGHT * 1100 * left
	f.from_left = bool(left)
	add_child(f)
	
	if idx == max_numbers - 1:
		numbers.shuffle()
