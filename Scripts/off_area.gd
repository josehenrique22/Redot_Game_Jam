extends Area2D

@export var player_1:Node2D
@export var player_2:Node2D
@export var spawn_point:Node2D
@export var spawn_point_2:Node2D
@export var obj:Node2D
@export var offset:Vector2

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player1"):
		player_1.position = spawn_point.global_position + offset
		print("hit")
		
	if area.is_in_group("player2"):
		player_2.position = spawn_point_2.global_position + offset
		print("hit")
