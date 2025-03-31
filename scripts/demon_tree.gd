extends demon

@export var bullet_prefab : PackedScene 

var rng = RandomNumberGenerator.new()

var player
func _jump():
	if is_active == false:
		return
	#$AnimatedSprite2D.play("fire")
	$AnimatedSprite2D.play("default")
	var bullet = bullet_prefab.instantiate()
	get_parent().add_child(bullet)
	bullet.position = Vector2(position.x, position.y)
	var random_direction = rng.randi_range(0, 1)
	if random_direction == 0: random_direction = -1
	bullet.movementDirection = Vector2(-1,(1 * random_direction))
	
func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_active = true
		
func _check_death():
	if health <= 0:
		is_active = false
		$AnimatedSprite2D.modulate = Color("000000")
		await get_tree().create_timer(1).timeout
		Signals.emit_signal("game_won")
		queue_free()
