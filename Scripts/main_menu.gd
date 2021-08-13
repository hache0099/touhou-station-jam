extends Control

func _ready():
	pass

func _on_volumen_value_changed(value):
	AudioServer.set_bus_volume_db(0, linear2db(value))


func _on_play_pressed():
	get_tree().change_scene("res://Scenes/juego.tscn")
