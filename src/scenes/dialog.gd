extends Node2D

func _ready():
	get_tree().paused = true

func initialize(type):
	$AnimationPlayer.play("new_animation")
	Global.POSSESSIONS.push_back(type)
	$character.animation = Global.CHARS_DATA[type].title.to_lower()
	$lbl_title.text = Global.CHARS_DATA[type].title
	$lbl_description.text = Global.CHARS_DATA[type].description
	
func _physics_process(delta):
	rotation = $Node2D.rotation
	if Input.is_action_just_pressed("start"):
		btn_pressed()
	
func _on_btn_pressed():
	btn_pressed()

func btn_pressed():
	get_tree().paused = false
	queue_free()
	visible = false
