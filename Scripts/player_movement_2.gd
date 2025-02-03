extends Area2D

@export var control_resource: PlayerControlResource
@onready var walk_sound = $AudioStreamPlayer2D  
var can_move: bool = true
var was_moving_down: bool = false
var was_moving_up: bool = false

var anim
var dir
var is_moving

func enable_control() -> void:
	can_move = true

func disable_control() -> void:
	can_move = false

func _ready():
	anim = $Sprite2D/AnimationPlayer
	if not control_resource:
		control_resource = PlayerControlResource.new()

func _process(delta: float) -> void:
	dir = control_resource.direction
	is_moving = dir.length() > 0
	
	if dir == Vector2.ZERO:
		if was_moving_down:
			anim.play("idle")
		elif was_moving_up:
			anim.play("idle_up")
	elif dir.y < 0:
		was_moving_up = true
		was_moving_down = false
		anim.play("walk_up")
	elif dir.y > 0: 
		was_moving_up = false
		was_moving_down = true
		anim.play("down_walk")
	elif dir.x != 0: 
		if was_moving_down:
			anim.play("down_walk")
		elif was_moving_up:
			anim.play("walk_up")

	if is_moving:
		if not walk_sound.playing:
			walk_sound.play()
	else:
		if walk_sound.playing:
			walk_sound.stop()

	if can_move:
		control_resource.player_control(self, delta)
