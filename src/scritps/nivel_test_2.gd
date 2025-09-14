extends Node2D

@onready var contenedor = $CartaContainer
var cartas_seleccionadas : Array = []
var valores_disponibles = ["10","11","12", "13", "14", "15", "16", "17", "18"] # 9 valores = 18 cartas
var bloqueando_input : bool = false

func _ready():
	iniciar_juego()

func _process(delta: float) -> void:
	GameState.actualizar_tiempo(delta)
	if not AudioManager.get_node("Nivel").is_playing():
		AudioManager.get_node("Nivel").play()
	
func iniciar_juego():
	var baraja = generar_baraja()
	baraja.shuffle()
	colocar_cartas(baraja)

func generar_baraja() -> Array:
	var baraja = []
	
	for valor in valores_disponibles:
		baraja.append(valor)
		baraja.append(valor)  # Agregamos el par
		
	#while baraja.size() < 36:
	#	var valor_extra = valores_disponibles[randi() % valores_disponibles.size()]
	#	baraja.append(valor_extra)
	#	baraja.append(valor_extra)
	var extras = 18 - baraja.size()
	for i in range(int(extras / 2)):
		var valor_extra = valores_disponibles[i % valores_disponibles.size()]
		baraja.append(valor_extra)
		baraja.append(valor_extra)
		
	baraja.resize(18)  # Por si se pasó de 36
	return baraja

func colocar_cartas(baraja: Array):
	var filas = 3
	var columnas = 6
	var indice = 0
	
	var ancho_carta = 60  # ancho real del sprite * scale
	var alto_carta = 100  # alto real del sprite * scale
	var margen_x = 80     # espacio horizontal entre cartas
	var margen_y = 110    # espacio vertical entre cartas
	
	
	for y in range(filas):
		for x in range(columnas):
			var carta = preload("res://src/scenes/carta.tscn").instantiate()
			carta.valor = baraja[indice]
			carta.connect("carta_seleccionada", Callable(self, "_on_carta_seleccionada"))
			var pos_x = x * (ancho_carta + margen_x)
			var pos_y = y * (alto_carta + margen_y)
			#carta.position = Vector2(x * 100, y * 200)  # Ajusta según tamaño de carta
			carta.position = Vector2( pos_x, pos_y)
			contenedor.add_child(carta)
			
			carta.volteada = true
			carta.sprite.play(carta.valor)
			
			indice += 1
			print("Baraja mezclada: ", baraja)

	get_tree().create_timer(1.0).connect("timeout", Callable(self, "_ocultar_todas"))

func _on_carta_seleccionada(carta):
	
	if bloqueando_input:
		return
		
	if carta in cartas_seleccionadas:
		return
	
	cartas_seleccionadas.append(carta)
	
	if cartas_seleccionadas.size() == 2:
		bloqueando_input = true
		for c in cartas_seleccionadas:
			c.set_input_enabled(false)
		get_tree().create_timer(3.0).connect("timeout", Callable(self, "_comprobar_pareja"))

func _comprobar_pareja():
	var carta1 = cartas_seleccionadas[0]
	var carta2 = cartas_seleccionadas[1]

	if carta1.valor == carta2.valor:
		carta1.ocultar()
		carta2.ocultar()
		AudioManager.get_node("Yay").play()
	else:
		carta1.volteada = false
		carta1.sprite.play("reverso")
		carta2.volteada = false
		carta2.sprite.play("reverso")
		AudioManager.get_node("No").play()
	
	cartas_seleccionadas.clear()
	
	for c in contenedor.get_children():
		if c.visible:
			c.set_input_enabled(true)
	
	bloqueando_input = false
	comprobar_fin_juego()

func comprobar_fin_juego():
	var cartas_visibles = contenedor.get_children().filter(func(c): return c.visible)
	if cartas_visibles.is_empty():
		print("🎉 ¡Ganaste!")
		get_tree().change_scene_to_file("res://src/scenes/winolose.tscn")

func _ocultar_todas():
	for carta in contenedor.get_children():
		carta.volteada = false
		carta.sprite.play("reverso")
		carta.set_input_enabled(true)
