extends CharacterBody2D

@export var speed = 1200
@export var jump_speed = -1800
@export var gravity = 4000
@export_range(0.0, 1.0) var friction = 0.1
@export_range(0.0 , 1.0) var acceleration = 0.25

var heldItem : Node2D
var facing_dir

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left"):
		$Sprite2D.flip_h = true
		facing_dir = -1
	if Input.is_action_just_pressed("right"):
		$Sprite2D.flip_h = false
		facing_dir = 1

func _physics_process(delta):
	velocity.y += gravity * delta
	var dir = Input.get_axis("left", "right")
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)
		
	move_and_slide()
	if Input.is_action_just_pressed("action_1") and is_on_floor():
		velocity.y = jump_speed
	if Input.is_action_just_released("down") and is_on_floor():
		get_parent().new_rabbit(position)
	if Input.is_action_just_pressed("action_2"):
		if heldItem == null:
			return
		heldItem._throw(Vector2(facing_dir * 5, 0))
		
		
func equip(item : Node2D):
	heldItem = item
	
