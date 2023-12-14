extends Node2D

func _ready():
	visible = false
	Global.DIALOG_OBJ = self
	
func hide_balloon():
	visible = false

func show_balloon(who, message):
	visible = true
	$Label.text = message
	$AvatarGhost.animation = who
