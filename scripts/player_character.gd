extends CharacterBody2D

@export var speed = 1200
@export var jump_speed = -1800
@export var gravity = 4000
@export_range(0.0, 1.0) var friction = 0.1
@export_range(0.0 , 1.0) var acceleration = 0.25

var current_jumps = 0
var max_jumps = 1

var heldItem : Node2D
var facing_dir
var is_dead : bool = false
var is_frozen : bool = false
var tilemap : TileMapLayer

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left"):
		$Sprite2D.flip_h = true
		facing_dir = -1
	if Input.is_action_just_pressed("right"):
		$Sprite2D.flip_h = false
		facing_dir = 1

func _physics_process(delta):
	velocity.y += gravity * delta
	if is_frozen == true:
		return;
	var dir = Input.get_axis("left", "right")
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)
		
	move_and_slide()
	if Input.is_action_just_pressed("action_1"):
		if current_jumps < max_jumps:
			velocity.y = jump_speed
			current_jumps += 1
			if is_on_floor() == false:
				get_parent().new_rabbit(self)
			
	#if Input.is_action_just_released("down") and is_on_floor():
		#get_parent().new_rabbit(position)
	if Input.is_action_just_pressed("action_2"):
		if heldItem == null:
			return
		heldItem._throw(Vector2(facing_dir * 5, 0))
		heldItem = null
		
	if is_on_floor():
		current_jumps = 0
	
	#spike detection
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider() is TileMapLayer:
			var data : TileData = collision.get_collider().get_cell_tile_data(collision.get_collider().get_coords_for_body_rid(collision.get_collider_rid()))
			if data == null: 
				return
			var is_spike = data.get_custom_data("Damage")
			if is_spike == true and is_dead == false:
				get_parent().rabbit_death(self)
				is_dead = true

func equip(item : Node2D):
	heldItem = item
	
	
