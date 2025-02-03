extends Area2D

@export var point_object_1:Node2D  
@export var point_object_2:Node2D  
@export var player1:Node2D
@export var player2:Node2D

@onready var pick_sound = $pick_sound
@onready var throw_sound = $throw_sound

var follow_player = null  
var offset = Vector2(8, 88)  

var is_thrown = false  
var start_position:Vector2  
var target_position:Vector2  
var control_point:Vector2  # Ponto de controle para a curva (altura do arco)
var t:float = 0.0  
@export var throw_duration:float = 0.5  # Tempo de movimento (em segundos)
@export var arc_height:float = 100  # Altura do arco da curva

func _ready() -> void:
	z_index = -1  

func _process(delta:float) -> void:
	# Se o botão direito for pressionado, lança o objeto e estiver segurando o objeto(bola)
	if Input.is_action_just_pressed("right_click") and follow_player:
		throw_sound.play()
		launch_object()

func _physics_process(delta:float) -> void:
	if is_thrown:
		# Interpolação para mover o objeto ao longo da curva
		t += delta / throw_duration  # Aumenta o tempo para o movimento

		if t >= 1.0:
			t = 1.0
			is_thrown = false  # Após alcançar o destino, o movimento para
			global_position = target_position  # Coloca o objeto no destino final
			return

		# Movimento ao longo da curva Bézier
		global_position = bezier_curve(start_position, control_point, target_position, t)

	elif follow_player:
		# Só segue o jogador enquanto não for lançado
		position = follow_player.global_position + offset

# Função para lançar o objeto
func launch_object():
	is_thrown = true
	t = 0.0  # Reinicia o tempo de movimento

	# Desativa o seguimento do jogador após o lançamento
	follow_player = null

	# Posição de lançamento (do jogador ou ponto que o objeto está)
	start_position = global_position  
	target_position = get_global_mouse_position()  # Posição de destino (onde o mouse foi clicado)

	# Ponto de controle para a curva (meio do caminho, ajustando a altura do arco)
	control_point = (start_position + target_position) / 2 + Vector2(0, -arc_height)  # Ajuste da altura do arco

# Função para calcular a curva Bézier quadrática
func bezier_curve(p0:Vector2, p1:Vector2, p2:Vector2, t:float) -> Vector2:
	# Fórmula de curva Bézier quadrática
	return (1 - t) * (1 - t) * p0 + 2 * (1 - t) * t * p1 + t * t * p2

# Funções de "follow_player" mantidas, para que o objeto siga o jogador até ser lançado
func _on_area_entered(area:Area2D) -> void:
	if area.is_in_group("player1"):
		pick_sound.play()
		follow_player = point_object_1  

	if area.is_in_group("player2"):
		follow_player = point_object_2  
		pick_sound.play()
		
func _on_area_exited(area:Area2D) -> void:
	if area.is_in_group("player1") or area.is_in_group("player2"):
		follow_player = null
