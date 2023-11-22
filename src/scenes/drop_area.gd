extends Area2D
var coef = 35

func drop(force, direction):
	var areas = get_overlapping_bodies()
	for area in areas:
		if area.is_in_group("interactuable"):
			area.tiny_jump()
			area.pushed(force * coef, direction)
