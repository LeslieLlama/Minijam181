extends Area2D

func _on_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("player"):
		Signals.emit_signal("new_room_entered", self, body)
		



func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		Signals.emit_signal("room_exited", self, body)
