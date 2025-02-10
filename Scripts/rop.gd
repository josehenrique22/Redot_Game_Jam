extends Area2D

@export var p_1: Node2D
@export var p_2: Node2D
@onready var sprite: Sprite2D = $Rope   
@onready var win = $"../Win"
var holding_p1 = false
var holding_p2 = false

func _process(delta: float) -> void:
	if holding_p1 and holding_p2:
		var mid_point = (p_1.global_position + p_2.global_position) / 2
		global_position = mid_point

		var direction = p_2.global_position - p_1.global_position
		rotation = direction.angle()

		var distance = p_1.global_position.distance_to(p_2.global_position)
		sprite.scale.x = distance / sprite.texture.get_size().x

		# Tornar o 'win' visível quando ambos estiverem segurando o objeto
		win.visible = true
			
	elif holding_p1:
		global_position = p_1.global_position
	elif holding_p2:
		global_position = p_2.global_position

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player1"):
		holding_p1 = true
	elif area.is_in_group("player2"):
		holding_p2 = true

func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("player1"):
		holding_p1 = false
	elif area.is_in_group("player2"):
		holding_p2 = false
