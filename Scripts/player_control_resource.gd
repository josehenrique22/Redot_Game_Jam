extends Resource

class_name PlayerControlResource

var speed:int = 120
var direction: Vector2
var can_move: bool = true

func player_control(node: Node2D, delta: float) -> void:
	if can_move:
		direction = Input.get_vector("left", "right", "up", "down")
		var velocity = direction * speed

		if direction != Vector2.ZERO:
			direction = direction.normalized()
			
		node.position += velocity * delta

func enable_control() -> void:
	can_move = true

func disable_control() -> void:
	can_move = false
