extends Node2D

export(PackedScene) var frutas

func _ready():
	pass

func _on_fruta_spawner_timeout():
	var f = frutas.instance()
	
