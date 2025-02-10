extends Area2D

@export var player1:Node2D
@export var player2:Node2D
@export var p1:Node2D

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player1"):
		player1.global_position = p1.global_position
	
	if area.is_in_group("player2"):
		player2.global_position = p1.global_position
