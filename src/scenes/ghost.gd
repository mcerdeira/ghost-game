extends Node2D
var posses_speed = 7
var normal_speed = 2
var dash_pos = []

var speed = normal_speed
var dest = null
var possesing = false
var possed_char = null

func _ready():
	Global.GHOST = self
	$sprite.play()
	
func set_dest(_dest):
	if Global.IN_OTHER:
		global_position = possed_char.global_position
		speed = normal_speed
		possed_char.mode = "npc"
		visible = true
		Global.IN_OTHER = false
		dest = _dest
		possed_char = null
		custom_look_at(dest)
	
func set_possesed(_obj):
	Global.BlackEffect.visible = true
	possed_char = _obj
	possed_char.z_index = 1
	dest = _obj.global_position
	possesing = true
	speed = posses_speed
	custom_look_at(dest)
	
func custom_look_at(target):
	if global_position.x > target.x:
		$sprite.scale.x = -1
	else:
		$sprite.scale.x = 1

func _process(delta):
	if !Global.IN_OTHER:
		if !possesing:
			if Input.is_action_just_pressed("click"):
				dest = get_global_mouse_position()
				custom_look_at(dest)
				
		if possesing:
			dash_pos.append(Vector2(position.x -16, position.y - 16))
			queue_redraw()
				
			if global_position.distance_to(dest) <= 1:
				dash_pos = []
				Global.BlackEffect.visible = false
				possed_char.z_index = 0
				possed_char.mode = "player"
				dest = null
				get_tree().paused = false
				possesing = false
				visible = false
				Global.IN_OTHER = true
			
		if dest != null:
			global_position.x = lerp(global_position.x, dest.x, speed * delta)
			global_position.y = lerp(global_position.y, dest.y, speed * delta)

func _draw():
	if possesing:
		var texture = $sprite.get_sprite_frames().get_frame_texture($sprite.animation, 0)
		for p in dash_pos:
			draw_texture(texture, to_local(p), Color(1, 1, 1, 0.3))
