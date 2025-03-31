extends Area2D

class_name bullet
var invincible = true
@export var movementDirection : Vector2 = Vector2(-1,0)

func _ready() -> void:
	await get_tree().create_timer(0.2).timeout
	invincible = false

func _process(delta: float) -> void:
	position += movementDirection

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.external_death()
		queue_free()
	else:
		if invincible == true:
			return
		queue_free()
