extends demon

@export var bullet_prefab : PackedScene 
var facing_dir = -1

var player
func _jump():
	if is_active == false:
		return
	$AnimatedSprite2D.play("fire")
	
	await get_tree().create_timer(0.6).timeout
	$AnimatedSprite2D.play("default")
	var bullet = bullet_prefab.instantiate()
	get_parent().add_child(bullet)
	bullet.position = Vector2(position.x, position.y)
	bullet.movementDirection = (Vector2(facing_dir * 7, 0))
	
func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_active = true
		if body.global_position.x > global_position.x:
			facing_dir = 1
			$AnimatedSprite2D.flip_h = true
		else: 
			facing_dir = -1
			$AnimatedSprite2D.flip_h = false
			
func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		pass
