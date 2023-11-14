extends Node2D
var speed = 2
var blue = 0.0
var dir = 1
var val = 0.001
var win_ttl = 3

func _ready():
	Global.level_name = get_tree().get_current_scene().get_name()
	$Area2D.visible = true
	Global.BlackEffect = $BlackEffect
	$BlackEffect.visible = false
	Global.tutorial_lbl = $lbl_tutorial
	
func _physics_process(delta):
	if Input.is_action_just_pressed("restart"):
		Global.init()
		get_tree().reload_current_scene()
	
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
		
	if Input.is_action_pressed("toggle_fullscreen"):
		Global.FULLSCREEN = !Global.FULLSCREEN
		if Global.FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	$lbl_fruits.text = "FRUITS: " + str(Global.FRUITS) + " / " + str(Global.TOTAL_FRUITS)
	$background.rotation_degrees += (speed * -1) * delta
	
	if Global.WIN:
		$Camera2D.zoom.x = lerp($Camera2D.zoom.x, 3.0, 0.01)
		$Camera2D.zoom.y = $Camera2D.zoom.x
		$Camera2D.position.x =  lerp($Camera2D.position.x, $portal.position.x, 0.01)
		$Camera2D.position.y =  lerp($Camera2D.position.y, $portal.position.y, 0.01)
		win_ttl -= 1 * delta
		if win_ttl <= 0:
			Global.LEVEL += 1
			var next_level = "res://scenes/levels/level" + str(Global.LEVEL) +".tscn"
			Global.init()
			get_tree().change_scene_to_file(next_level)

	
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

