extends Camera2D

@export var point_position_1:Node2D

func _process(delta: float) -> void:
	position = point_position_1.position
