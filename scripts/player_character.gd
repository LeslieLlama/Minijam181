extends CharacterBody2D

@export var speed = 1200
@export var jump_speed = -1800
@export var gravity = 4000
@export_range(0.0, 1.0) var friction = 0.1
@export_range(0.0 , 1.0) var acceleration = 0.25

@export var knife_prefab : PackedScene 

var current_jumps = 0
var max_jumps = 1

#var heldItem : Node2D
var current_knife : Node2D
var facing_dir
var is_dead : bool = false
var is_frozen : bool = false
var is_throwing : bool = false
var tilemap : TileMapLayer
var animated_sprite : AnimatedSprite2D


func _ready() -> void:
	facing_dir = 1
	animated_sprite = $Sprite2D

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left"):
		animated_sprite.flip_h = true
		facing_dir = -1
	if Input.is_action_just_pressed("right"):
		animated_sprite.flip_h = false
		facing_dir = 1
		


func _physics_process(delta):
	velocity.y += gravity * delta
	move_and_slide()
	
	if is_dead == true:
		return
		
	if Input.is_action_just_pressed("action_2"):
		#if heldItem == null:
			#return
		#heldItem._throw(Vector2(facing_dir * 5, 0))
		#heldItem = null
		if current_knife != null:
			return
		is_throwing = true
		await get_tree().create_timer(0.2).timeout
		is_throwing = false
		var knife = knife_prefab.instantiate()
		get_parent().add_child(knife)
		knife.position = Vector2(position.x, position.y - 10)
		knife._throw(Vector2(facing_dir * 7, 0))
		current_knife = knife
	
	if is_frozen == true:
		return;
	
	var dir = Input.get_axis("left", "right")
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)
		
	if Input.is_action_just_pressed("down") and is_on_floor():
		position.y += 1
		
	
	if Input.is_action_just_pressed("action_1"):
		if current_jumps < max_jumps:
			velocity.y = jump_speed
			current_jumps += 1
			if is_on_floor() == false:
				get_parent().new_rabbit(self)
			
	#if Input.is_action_just_released("down") and is_on_floor():
		#get_parent().new_rabbit(position)
	
		
		
	if is_on_floor():
		current_jumps = 0
	
	#sprite animation
	if is_throwing == true:
		animated_sprite.play("throw")
	elif dir != 0 and is_on_floor():
		animated_sprite.play("running")
	elif is_on_floor() == false and current_jumps >= 1:
		animated_sprite.play("double_jump")
	elif is_on_floor() == false:
		animated_sprite.play("jump")
	else: 
		animated_sprite.play("default")
	
	#spike detection
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider() is TileMapLayer:
			var data : TileData = collision.get_collider().get_cell_tile_data(collision.get_collider().get_coords_for_body_rid(collision.get_collider_rid()))
			if data == null: 
				return
			var is_spike = data.get_custom_data("Damage")
			if is_spike == true and is_dead == false:
				external_death()

#func equip(item : Node2D):
	#heldItem = item
	
func external_death():
	velocity = Vector2(500*-facing_dir,-500)
	is_dead = true
	animated_sprite.play("death")
	collision_layer = 0b00000000_00000000_00000000_00000000
	collision_mask = 0b00000000_00000000_00000000_00000000
	await get_tree().create_timer(1).timeout
	get_parent().rabbit_death(self)
	
	
	
