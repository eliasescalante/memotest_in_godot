extends Node2D

@onready var animacion = $AnimationPlayer
var menu_audio = AudioManager.get_node("MenuYCreditos")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animacion.play("transicion")
	menu_audio.play()
	# Reproducir música de menú en loop
	

	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	ir_a_menu()
	pass

func ir_a_menu():
	if !animacion.is_playing():
		get_tree().change_scene_to_file("res://src/scenes/menu.tscn")
