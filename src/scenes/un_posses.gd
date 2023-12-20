extends Area2D
var body_loco = null
var forward = false
var possesed_obj = preload("res://scenes/possesed.tscn")
@export var _animation : NodePath
@onready var animation : AnimationPlayer = get_node(_animation) as AnimationPlayer

func _on_body_entered(body):
	if body.is_in_group("npc"):
		if Global.IN_OTHER:
			body_loco = body
			$AnimationPlayer.play("new_animation")
			
func play_SPRING_SFX():
	Global.play_sound(Global.SPRING_SFX)

func _on_animation_player_animation_finished(anim_name):
	forward = !forward
	if forward:
		Music.stop()
		body_loco.visible = false
		Global.shaker_obj.shake(50, 2.1)
		Global.play_sound(Global.POSSES_SFX)
		Global.GHOST.set_dest($spawn_point.global_position)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		Global.play_sound(Global.BOBM_SFX)
		Global.DIALOG_OBJ.show_balloon("ghost", "OMG!! What just happened???")
		await get_tree().create_timer(5).timeout 
		Global.DIALOG_OBJ.show_balloon("ghost", "Where am I?? I Just...")
		await get_tree().create_timer(5).timeout 
		Global.DIALOG_OBJ.show_balloon("ghost_scared", "D I E D ?????????")
		await get_tree().create_timer(8).timeout 
		Global.DIALOG_OBJ.hide_balloon()
		var pos_o = possesed_obj.instantiate()
		get_parent().add_child(pos_o)
		pos_o.global_position = Vector2(body_loco.global_position.x, 432)
		pos_o.animation_player = animation
		body_loco.queue_free()
		$AnimationPlayer.play("new_animation_2")
	else:
		Global.shaker_obj.shake(20, 2.1)
		Global.play_sound(Global.BOBM_SFX)
