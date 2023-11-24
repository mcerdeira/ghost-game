extends Node2D

func _ready():
	get_tree().paused = true

func initialize(type):
	$AnimationPlayer.play("new_animation")
	Global.POSSESSIONS.push_back(type)
	$character.animation = Global.CHARS_DATA[type].title.to_lower()
	$lbl_title.text = Global.CHARS_DATA[type].title
	$lbl_description.text = Global.CHARS_DATA[type].description
	
func _on_btn_pressed():
	get_tree().paused = false
	queue_free()
	visible = false
