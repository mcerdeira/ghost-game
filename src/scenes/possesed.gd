extends Node2D
var follow = true
var animation_player = null

func _physics_process(delta):
	if follow:
		if Global.GHOST:
			if global_position.x > Global.GHOST.global_position.x:
				scale.x = -1
			else:
				scale.x = 1
				
func play_portal_sfx():
	Global.play_sound(Global.PORTAL_SFX)

func _ready():
	await get_tree().create_timer(2).timeout
	Global.play_sound(Global.LAUGH_SFX)
	await get_tree().create_timer(3).timeout
	Music.play(Global.intro_PanicTheme)
	Global.DIALOG_OBJ.show_balloon("possessed1", "HA HA HA!!!")
	await get_tree().create_timer(5).timeout 
	Global.DIALOG_OBJ.show_balloon("possessed1", "After so many years...")
	await get_tree().create_timer(5).timeout 
	Global.DIALOG_OBJ.show_balloon("possessed1", "A fresh one fell into my trap!!")
	await get_tree().create_timer(5).timeout 
	Global.DIALOG_OBJ.show_balloon("ghost", "Wait... What?")
	follow = true
	$AnimatedSprite2D.animation = "2"
	await get_tree().create_timer(5).timeout 
	Global.DIALOG_OBJ.show_balloon("possessed", "Now, the sack of meat you call 'body' is mine!")
	await get_tree().create_timer(4).timeout 
	
	Global.DIALOG_OBJ.show_balloon("possessed", "...and now I can scape from this place!!")
	await get_tree().create_timer(4).timeout 
	
	Global.DIALOG_OBJ.show_balloon("possessed", "F I N A L L Y!!")
	await get_tree().create_timer(4).timeout 
	
	Global.DIALOG_OBJ.hide_balloon()
	$portal.visible = true
	$AnimatedSprite2D.animation = "1"
	Global.shaker_obj.shake(20, 2.1)
	await get_tree().create_timer(7).timeout 
	$AnimationPlayer.play("new_animation")
	Global.play_sound(Global.LAUGH_SFX)
	await get_tree().create_timer(5).timeout 
	Global.DIALOG_OBJ.show_balloon("ghost_scared", "Oh no!! I'm trapped here FOREVER???")
	await get_tree().create_timer(9).timeout 
	Global.DIALOG_OBJ.hide_balloon()
	animation_player.play("new_animation")
	await get_tree().create_timer(6).timeout
	Global.DIALOG_OBJ.show_balloon("entity", "YOU FOOL!!!!!")
	await get_tree().create_timer(5).timeout
	Global.DIALOG_OBJ.show_balloon("ghost_scared", "AAAAAAAAHHHHHHHHHHHH!!!!!!!!")
	await get_tree().create_timer(5).timeout
	Global.DIALOG_OBJ.show_balloon("entity", "S I L E N C E!!!!!!")
	await get_tree().create_timer(5).timeout
	Global.DIALOG_OBJ.show_balloon("entity", "I'm the God of death and fire")
	
	await get_tree().create_timer(5).timeout
	Global.DIALOG_OBJ.show_balloon("ghost_scared", "...")
	
	await get_tree().create_timer(5).timeout
	Global.DIALOG_OBJ.show_balloon("entity", "My name is TEZLOTECALMEC... but you can just call me 'TEZ'")
	await get_tree().create_timer(5).timeout
	Global.DIALOG_OBJ.show_balloon("ghost_scared", "I... I... I... just...")
	await get_tree().create_timer(5).timeout
	Global.DIALOG_OBJ.show_balloon("entity", "You just unleashed a very dangerous evil...")
	await get_tree().create_timer(5).timeout
	Global.DIALOG_OBJ.show_balloon("entity", "And know you must fix it!!")
	await get_tree().create_timer(5).timeout
	Global.DIALOG_OBJ.show_balloon("entity", "Recover your body, stop the evil and restore peace...")
	await get_tree().create_timer(5).timeout
	Global.DIALOG_OBJ.show_balloon("entity", "NOW GO!!!!!!!!!")
	await get_tree().create_timer(5).timeout
	Global.WIN = true
