extends Area2D
var is_on = false
var speed = 120

func _ready():
	is_on = true
	$sprite.modulate.a = 1
	Global.PORTAL = self
	speed = 500
	$sprite.play()
	$AnimationPlayer.play("new_animation")
	$rays.rotation_degrees = randi() % 360
	$rays.visible = true
	$AnimationPlayer2.play("new_animation")
	
func _process(delta):
	if visible:
		$sprite.rotation_degrees += speed * delta
		if randi() % 50 == 0:
			Global.emit(global_position, 1)


