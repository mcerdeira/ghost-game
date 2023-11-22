extends Node2D
var focus_on = false

func _ready():
	modulate.a = 0.1
	if !Global.MUSIC_ENABLED:
		$sprite.frame = 1
	else:
		$sprite.frame = 0
		
func _physics_process(delta):
	if focus_on:
		modulate.a = lerp(modulate.a, 1.0, 0.1)
	else:
		modulate.a = lerp(modulate.a, 0.1, 0.1)

func _on_btn_pressed():
	Global.MUSIC_ENABLED = !Global.MUSIC_ENABLED
	
	if !Global.MUSIC_ENABLED:
		$sprite.frame = 1
		if Global.MUSIC_PLAYING:
			Music.pause()
	else:
		$sprite.frame = 0
		if !Global.MUSIC_PLAYING:
			Music.play(Global.MainTheme)
		else:
			Music.resume()

func _on_btn_mouse_entered():
	focus_on = true

func _on_btn_mouse_exited():
	focus_on = false
