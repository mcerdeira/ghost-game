extends Node2D
var speed = 2
var win_ttl = 3
var music_btn_obj = preload("res://scenes/music_btn.tscn")

func _ready():
	if Global.MUSIC_ENABLED:
		if !Global.MUSIC_PLAYING:
			Global.MUSIC_PLAYING = true
			Music.play(Global.MainTheme)
			
	var mbtn = music_btn_obj.instantiate()
	add_child(mbtn)
	mbtn.position = Vector2(1127, 623)
		
	$background_animation.play("new_animation")
	Global.level_name = get_tree().get_current_scene().get_name()
	$Area2D.visible = true
	Global.BlackEffect = $BlackEffect
	$BlackEffect.visible = false
	Global.tutorial_lbl = $lbl_tutorial
	
func _physics_process(delta):	
	if Input.is_action_just_pressed("WIN"):
		Global.WIN = true
	
	if Input.is_action_just_pressed("restart"):
		Global.init()
		get_tree().reload_current_scene()
	
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
		
	if Input.is_action_pressed("toggle_fullscreen"):
		Global.FULLSCREEN = !Global.FULLSCREEN
		if Global.FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			return
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			return
			
	
	if Global.level_name == "Title":
		if Input.is_action_just_pressed("start"):
			Global.WIN = true
	
	if Global.level_name != "Title":
		$lbl_fruits.text = "FRUITS: " + str(Global.FRUITS) + " / " + str(Global.TOTAL_FRUITS)
	$background.rotation_degrees += (speed * -1) * delta
	
	if Global.WIN:
		if Global.level_name == "Title":
			$Camera2D.zoom.x = lerp($Camera2D.zoom.x, 9.0, 0.01)
			$Camera2D.zoom.y = $Camera2D.zoom.x
			$Camera2D.position.x =  lerp($Camera2D.position.x, $ghost.position.x, 0.01)
			$Camera2D.position.y =  lerp($Camera2D.position.y, $ghost.position.y, 0.01)
		else:
			$Camera2D.zoom.x = lerp($Camera2D.zoom.x, 3.0, 0.01)
			$Camera2D.zoom.y = $Camera2D.zoom.x
			$Camera2D.position.x =  lerp($Camera2D.position.x, $portal.position.x, 0.01)
			$Camera2D.position.y =  lerp($Camera2D.position.y, $portal.position.y, 0.01)
		win_ttl -= 1 * delta
		if win_ttl <= 0:
			Global.LEVEL += 1
			var next_level = Global.LEVELS[Global.LEVEL]
			Global.init()
			get_tree().change_scene_to_file(next_level)

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.double_click:
		Global.emit(get_global_mouse_position(), 2)
		Global.play_sound(Global.POSSES_SFX)
		Global.GHOST.set_dest(get_global_mouse_position())
