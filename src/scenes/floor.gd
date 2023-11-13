extends StaticBody2D

func _ready():
	add_to_group("red_door")

func open():
	visible = false
	$collision.queue_free()
