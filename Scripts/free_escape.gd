extends Area2D

@export var stop_1:Node
@export var stop_2:Node
@export var espace_1:Node
@export var free_colli:Node2D
@export var object:Node2D
@export var free_point:Node2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("object"):
		stop_1.queue_free()
		stop_2.queue_free()
		espace_1.queue_free()
		var colli_node = $CollisionShape2D
		free_colli.remove_child(colli_node)
		object.queue_free()
