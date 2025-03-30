extends RigidBody2D


var health = 3

var animated_sprite : AnimatedSprite2D
var movement_direction : Vector2

var is_active : bool = false

func _ready() -> void:
	animated_sprite = $AnimatedSprite2D
	animated_sprite.play()
	movement_direction = Vector2.LEFT
	

func _process(delta: float) -> void:
	if $WallDetector.is_colliding() == true:
		movement_direction *= -1
		$AnimatedSprite2D.flip_h = !$AnimatedSprite2D.flip_h 
		$WallDetector.target_position *= -1

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.external_death()

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("kunai"):
		health -= 1;
		$AnimatedSprite2D.material.set("shader_parameter/Enabled", true)
		await get_tree().create_timer(0.1).timeout
		$AnimatedSprite2D.material.set("shader_parameter/Enabled", false)
	_check_death()
	
func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_active = true

func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_active = false

func _jump():
	if is_active == false:
		return
	apply_impulse(Vector2.UP * 450)
	apply_impulse(movement_direction * 300)
	
func _check_death():
	if health <= 0:
		
		collision_layer = 0b00000000_00000000_00000000_00000000
		collision_mask = 0b00000000_00000000_00000000_00000000
		$AnimatedSprite2D.flip_v = true
		await get_tree().create_timer(1).timeout
		queue_free()
	
