extends Node

var tiempo_total : float = 0.0
var nivel_iniciado : bool = false

func iniciar_tiempo():
	tiempo_total = 0.0
	nivel_iniciado = true

func actualizar_tiempo(delta: float):
	if nivel_iniciado:
		tiempo_total += delta
