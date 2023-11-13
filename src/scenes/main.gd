extends Node2D
var speed = 2
var blue = 0.0
var dir = 1
var val = 0.001

func _ready():
	$Area2D.visible = true
	Global.BlackEffect = $BlackEffect
	$BlackEffect.visible = false
	
func _physics_process(delta):
	$lbl_fruits.text = "FRUITS: " + str(Global.FRUITS) + " / " + str(Global.TOTAL_FRUITS)
	$background.rotation_degrees += (speed * -1) * delta
	
	if Global.WIN:
		$lbl_win.visible = true
		$Camera2D.zoom.x = lerp($Camera2D.zoom.x, 3.0, 0.1)
		$Camera2D.zoom.y = $Camera2D.zoom.x
		$Camera2D.position.x =  lerp($Camera2D.position.x, 2.0, 0.1)
		$Camera2D.position.y =  lerp($Camera2D.position.y, 324.0, 0.1)
	
	if (1 - blue) <= val and dir == 1:
		dir = -1
	elif blue <= val and dir == -1:
		dir = 1
		
	if dir == 1:
		blue = lerp(blue, 1.0, val)
	else:
		blue = lerp(blue, 0.0, val) 
	
	$background.modulate = Color(1, 0, blue, 0.15)

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.double_click:
		Global.GHOST.set_dest(get_global_mouse_position())
