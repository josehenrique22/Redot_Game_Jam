extends Camera2D

@onready var player_1 = $"../Player"
@onready var player_2 = $"../Player2"

var target_position: Vector2 = Vector2.ZERO
var delay_speed = 0.8

func _process(delta: float) -> void:
	var desired_position = (player_1.global_position + player_2.global_position) / 2
	target_position = lerp(target_position, desired_position, delta / delay_speed)
	position = target_position
