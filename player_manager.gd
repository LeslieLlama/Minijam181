extends Node2D

var active_players = []
@export var rabbit_prefab : PackedScene 

func _ready() -> void:
	new_rabbit(Vector2(40,0))

func new_rabbit(current_rabbit_position : Vector2):
	var new_rabbit = rabbit_prefab.instantiate()
	new_rabbit.global_position = Vector2(current_rabbit_position.x-20, current_rabbit_position.y)
	add_child(new_rabbit)
	active_players.append(new_rabbit)
