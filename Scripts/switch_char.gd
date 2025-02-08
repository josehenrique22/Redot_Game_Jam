extends Node

@export var switch_player: SwitchPlayer

@export var player_node_1: Node2D
@export var player_node_2: Node2D

var count:float = 0.0
var wait_time:float = 0.8
var current_player

func _ready() -> void:
	if not switch_player:
		switch_player = SwitchPlayer.new()
	switch_player.initialize(player_node_1, player_node_2)
	current_player = player_node_1

func _process(delta: float) -> void:
	
	if Input.is_key_pressed(KEY_F) and count <= 0:
		switch_player.switch_player()
		count = wait_time
	
	if count > 0.0:
		count -= delta
