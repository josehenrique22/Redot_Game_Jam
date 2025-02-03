extends Resource

class_name SwitchPlayer

var current_player:Node
var player_1:Node
var player_2:Node

func initialize(player_1_node:Node, player_2_node:Node) -> void:
	self.player_1 = player_1_node
	self.player_2 = player_2_node
	current_player = player_1
	enable_controls(player_1)
	disable_controls(player_2)

func switch_player() -> void:
	if current_player == player_1:
		current_player = player_2
		enable_controls(player_2)
		disable_controls(player_1)
	else:
		current_player = player_1
		enable_controls(player_1)
		disable_controls(player_2)

func enable_controls(player:Node) -> void:
	if player.has_method("enable_control"):
		player.call("enable_control")

func disable_controls(player:Node) -> void:
	if player.has_method("disable_control"):
		player.call("disable_control")
