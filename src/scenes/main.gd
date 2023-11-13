extends Node2D
var speed = 10

func _ready():
	Global.BlackEffect = $BlackEffect
	$BlackEffect.visible = false

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.double_click:
		Global.GHOST.set_dest(get_global_mouse_position())
