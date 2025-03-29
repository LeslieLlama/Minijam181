extends Node2D

var active_players = []
var main_rabbit : Node2D
var max_players = 4
@export var tilemap : TileMapLayer
@export var rabbit_prefab : PackedScene 

var lives = 3

func _ready() -> void:
	inital_spawn(Vector2(40,0))
	assign_rabbit_positions()
	
func inital_spawn(position_to_spawn : Vector2):
	var new_rab = rabbit_prefab.instantiate()
	new_rab.global_position = Vector2(position_to_spawn.x, position_to_spawn.y)
	new_rab.tilemap = tilemap
	add_child(new_rab)
	active_players.append(new_rab)
	Signals.emit_signal("update_ui", active_players.size(), lives)

func new_rabbit(summoning_rabbit : Node2D):
	if active_players.size() >= max_players:
		return
	if summoning_rabbit != main_rabbit:
		return
	var new_rab = rabbit_prefab.instantiate()
	new_rab.global_position = Vector2(summoning_rabbit.position.x-20, summoning_rabbit.position.y)
	new_rab.tilemap = tilemap
	add_child(new_rab)
	active_players.append(new_rab)
	Signals.emit_signal("update_ui", active_players.size(), 1)
	
	
func assign_rabbit_positions():
	main_rabbit = active_players[0] 
	
	
func rabbit_death(rabbit : Node2D):
	var place = active_players.find(rabbit)
	rabbit.queue_free()
	active_players.pop_at(place)
	#await get_tree().create_timer(0.1).timeout
	Signals.emit_signal("update_ui", active_players.size(), 1)
	if active_players.size() <= 0:
		life_lost()
	else:
		assign_rabbit_positions()
	
func _process(delta: float) -> void:
	if main_rabbit != null:
		$MainRabbitIndicator.position = Vector2(main_rabbit.position.x, main_rabbit.position.y -40)
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("action_3"):
		for b in active_players:
			b.is_frozen = true
			if b == main_rabbit:
				b.is_frozen = false
	if Input.is_action_just_released("action_3"):
		for b in active_players:
			b.is_frozen = false

func life_lost():
	pass
