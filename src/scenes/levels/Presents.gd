extends Node2D
var memory = 64

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Music.play(Global.BOOT_SFX)

func _physics_process(delta):
	$lbl_text2.text = "Memory Test: " + str(round(memory)) + "K OK"
	memory += 50000 * delta
	if memory >= 262144:
		memory = 262144
		$lbl_text4.visible = true

func _on_timer_timeout():
	Global.WIN = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene_to_file("res://scenes/levels/Title.tscn")
