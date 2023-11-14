extends StaticBody2D

func _ready():
	add_to_group("red_door")

func open():
	visible = false
	$collision.set_deferred("disabled", true)

func close():
	visible = true
	$collision.set_deferred("disabled", false)
