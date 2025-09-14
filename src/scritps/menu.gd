extends Node2D

var menu_audio = AudioManager.get_node("MenuYCreditos")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	menu_audio.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not menu_audio.is_playing():
		menu_audio.play()
	pass


func _on_start_pressed() -> void:
	menu_audio.stop()
	get_tree().change_scene_to_file("res://src/scenes/nivel_test.tscn")
	pass # Replace with function body.


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://src/scenes/creditos.tscn")
	pass # Replace with function body.
