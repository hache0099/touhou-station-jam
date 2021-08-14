extends Control


func _on_volumen_value_changed(value, bus_idx):
	AudioServer.set_bus_volume_db(bus_idx, linear2db(value))

func _on_play_pressed():
	get_tree().change_scene("res://Scenes/juego.tscn")

func _on_options_pressed():
	$option_window.show()

func _on_Button_pressed():
	$option_window.hide()
