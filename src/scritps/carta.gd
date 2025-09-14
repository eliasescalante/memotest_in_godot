extends Area2D
class_name Carta

signal carta_seleccionada(carta)

@export var valor : String = ""
@onready var sprite = $AnimatedSprite2D

var volteada = false

func _ready():
	sprite.scale = Vector2(0.3, 0.3)
	input_pickable = true
	

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if !volteada:
			voltear()
			emit_signal("carta_seleccionada", self)

func voltear():
	volteada = !volteada
	if volteada:
		sprite.play(valor)  # Muestra animación de la carta correspondiente
	else:
		sprite.play("reverso")  # Vuelve al dorso

func ocultar():
	visible = false

func set_input_enabled(enabled: bool):
	input_pickable = enabled
