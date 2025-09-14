extends Node2D

@onready var tiempo_label = $TIME
var minutos = GameState.tiempo_total / 60.0


func _ready():
	minutos = int(minutos * 100) / 100.0  # redondear a 2 decimales
	tiempo_label.text = str(minutos) + " min"


func _on_play_pressed() -> void:
	GameState.tiempo_total = 0.0
	GameState.nivel_iniciado = false
	# Cargar el nivel 1
	get_tree().change_scene_to_file("res://src/scenes/menu.tscn")
	pass # Replace with function body.


func _on_button_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
