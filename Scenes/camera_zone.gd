extends Area2D

func _on_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("player"):
		print('body entered')
		Signals.emit_signal("new_room_entered", self, body)
