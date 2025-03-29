extends Area2D


var equipped_body : Node2D

var movementDirection : Vector2 = Vector2(-1,0)

func _process(delta: float) -> void:
	position += movementDirection
	if equipped_body == null:
		return;
	position = equipped_body.global_position
	

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		_equip(body)
		body.equip(self)
	else:
		movementDirection = Vector2.ZERO
		
func _equip(body : Node2D):
	equipped_body = body
	
func _throw(direction : Vector2):
	equipped_body = null
	movementDirection = direction
	if direction.normalized().x > 0:
		$Sprite2D.flip_v = true
	else: 
		$Sprite2D.flip_v = false
	
