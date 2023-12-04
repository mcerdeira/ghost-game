extends Area2D
var is_on = false
var speed = 120

func _ready():
	$sprite.modulate.a = 0.1
	Global.PORTAL = self
	$sprite.play()
	$AnimationPlayer.play("new_animation")
	
func set_on():
	$sprite.modulate.a = 1
	is_on = true
	$sprite.frame = 1
	speed = 200

func _process(delta):	
	$sprite.rotation_degrees += speed * delta
	if !is_on and Global.WIN:
		if randi() % 50 == 0:
			Global.emit(global_position, 1)

func _on_body_entered(body):
	if is_on and body.is_in_group("npc"):
		is_on = false
		speed = 500
		Global.WIN = true
		$rays.rotation_degrees = randi() % 360
		$rays.visible = true
		$lbl_win.visible = true
		$AnimationPlayer2.play("new_animation")
		body.global_position = global_position
		body.absorved()

