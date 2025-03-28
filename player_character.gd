extends CharacterBody2D

@export var speed = 1200
@export var jump_speed = -1800
@export var gravity = 4000
@export_range(0.0, 1.0) var friction = 0.1
@export_range(0.0 , 1.0) var acceleration = 0.25


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
	if Input.is_action_just_released("action_2") and is_on_floor():
		var new_rabbit = self.duplicate()
		new_rabbit.global_position = Vector2(global_position.x - 40, global_position.y)
		get_tree().root.get_child(0).add_child(new_rabbit)
