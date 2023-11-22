extends Area2D

func _on_body_entered(body):
	if body.is_in_group("interactuable") and get_parent() != body:
		body.little_jump()
