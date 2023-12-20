extends Node
enum npc_states {IDLE, ANGRY, INLOVE, INLOVE_CHASE}
enum npc_types {NONE, JUMPY, SLEEPY, WALKY, PUSHY, GRABY, FLAMY, FAKE}
var GHOST = null
var IN_OTHER = false
var BlackEffect = null
var FRUITS = 0
var TOTAL_FRUITS = 0
var PORTAL = null
var WIN = false
var FULLSCREEN = false
var level_name = ""
var tutorial_index = 0
var tutorial_lbl = null
var POSSESSIONS = []
var LEVEL = 0
var JUMP_SFX = null
var TELEPORT_SFX = null
var LASER_SFX = null
var SWITCH_SFX = null
var SPRING_SFX = null
var POSSES_SFX = null
var BITE_SFX = null
var BOBM_SFX = null
var LAUGH_SFX = null
var PORTAL_SFX = null
var particle = preload("res://scenes/particle2.tscn")
var SAVED_GAME = false
var PLAY_INTRO = true
var shaker_obj = null
var DIALOG_OBJ = null

var MUSIC_ENABLED = true
var MUSIC_PLAYING = false
var MainTheme = "res://music/Bone Yard Waltz - Loopable.ogg"

var introTheme = "res://music/Insistent.ogg"
var intro_PanicTheme = "res://music/panic_3.mp3"
var TUTORIALS = [
	"[CLICK TO MOVE THE GHOST AROUND]",
	"[RIGHT CLICK ON OTHERS TO POSSES]",
	"[CONTROL THE POSSESSED BODY:\n'WASD': Move\n'SPACE': Action\n'R': Restart]",
	"[GET ALL THE FRUITS TO UNLOCK THE PORTAL\nAND EXIT LEVEL THROUGH ACTIVED PORTAL]",
]

var CHARS_DATA = [{
},
{
	"title": "JUMPY",
	"description": "Action: Jumps around like a rabbit.",
},
{
	"title": "SLEEPY",
	"description": "Action: Falls asleep and does nothing.",
},
{
	"title": "WALKY",
	"description": "Action: Walks from right to left and left to right.",
}
,
{
	"title": "PUSHY",
	"description": "Action: Can push some boxes and other things.",
}
,
{
	"title": "GRABY",
	"description": "Action: Can grab and throw stuff.",
}
,
{
	"title": "FLAMY",
	"description": "Action: Spits fire like a dragon.",
}
]

var LEVELS = [
	"res://scenes/levels/Title.tscn",
	"res://scenes/levels/level0.tscn",
	"res://scenes/levels/level1.tscn",
	"res://scenes/levels/level2.tscn",
	"res://scenes/levels/level6.tscn",
	"res://scenes/levels/level3.tscn",
	"res://scenes/levels/level4.tscn",
	"res://scenes/levels/level5.tscn",
	"res://scenes/levels/level7.tscn",
	"res://scenes/levels/level8.tscn",
	"res://scenes/levels/level9.tscn",
	"res://scenes/levels/level10.tscn",
	"res://scenes/levels/level11.tscn",
	"res://scenes/levels/level12.tscn",
	"res://scenes/levels/level13.tscn",
	"res://scenes/levels/level14.tscn",
	"res://scenes/levels/level15.tscn",
	"res://scenes/levels/level16.tscn",
	"res://scenes/levels/level17.tscn"
]

func save_game():
	var saved_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	saved_game.store_var(Global.LEVEL)
	saved_game.close()
	
	var saved_poss = FileAccess.open("user://savepos.save", FileAccess.WRITE)
	saved_poss.store_var(Global.POSSESSIONS)
	saved_poss.close()
	
func load_game():
	var saved_game = FileAccess.open("user://savegame.save", FileAccess.READ)
	PLAY_INTRO = !saved_game
	if saved_game:
		var level = saved_game.get_var()
		if level:
			SAVED_GAME = true
			Global.LEVEL = level
			saved_game.close()
			
	var saved_poss = FileAccess.open("user://savepos.save", FileAccess.READ)
	if saved_poss:
		var pos = saved_poss.get_var()
		if pos:
			Global.POSSESSIONS = pos
			saved_poss.close()

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	load_sfx()
	load_game()
	
func load_sfx():
	POSSES_SFX = preload("res://sfx/172206__fins__teleport.wav")
	BITE_SFX = preload("res://sfx/Deep Gulp Sound Effect.mp3")
	PORTAL_SFX = preload("res://sfx/portal.mp3")
	SPRING_SFX = preload("res://sfx/spring.mp3")
	JUMP_SFX = preload("res://sfx/jump.wav")
	SWITCH_SFX = preload("res://sfx/click9.mp3")
	LASER_SFX = preload("res://sfx/saw.wav")
	TELEPORT_SFX = preload("res://sfx/teleportation sound effect.mp3")
	BOBM_SFX = preload("res://sfx/BombExplosionSfx.wav")
	LAUGH_SFX = preload("res://sfx/Kefka Laugh Sound Effect.mp3")
	
func emit(_global_position, count):
	for i in range(count):
		var p = particle.instantiate()
		add_child(p)
		p.global_position = _global_position

func next_tutorial(action):
	if action == "click" and (Global.tutorial_index == 1 or Global.tutorial_index == 0):
		Global.tutorial_lbl.text = Global.TUTORIALS[Global.tutorial_index]
		Global.tutorial_index += 1
	
	if action == "right-click" and Global.tutorial_index == 2:
		Global.tutorial_lbl.text = Global.TUTORIALS[Global.tutorial_index]
		Global.tutorial_index += 1
		
	if action == "fruit" and Global.tutorial_index == 3:
		Global.tutorial_lbl.text = Global.TUTORIALS[Global.tutorial_index]
		Global.tutorial_index += 1
		
	if Global.tutorial_index > Global.TUTORIALS.size() - 1:
		Global.tutorial_index = Global.TUTORIALS.size() - 1

func kill_particles():
	var part = get_tree().get_nodes_in_group("particles2") 
	for p in part:
		p.visible = false
		p.queue_free()

func init():
	tutorial_index = 0
	GHOST = null
	IN_OTHER = false
	BlackEffect = null
	FRUITS = 0
	TOTAL_FRUITS = 0
	PORTAL = null
	WIN = false

func pick_random(container):
	if typeof(container) == TYPE_DICTIONARY:
		return container.values()[randi() % container.size() ]
	assert( typeof(container) in [
			TYPE_ARRAY, TYPE_PACKED_COLOR_ARRAY, TYPE_PACKED_INT32_ARRAY,
			TYPE_PACKED_BYTE_ARRAY, TYPE_PACKED_FLOAT32_ARRAY, TYPE_PACKED_STRING_ARRAY,
			TYPE_PACKED_VECTOR2_ARRAY, TYPE_PACKED_VECTOR3_ARRAY
			], "ERROR: pick_random" )
	return container[randi() % container.size()]

func play_sound(stream: AudioStream, options:= {}) -> AudioStreamPlayer:
	var audio_stream_player = AudioStreamPlayer.new()

	add_child(audio_stream_player)
	audio_stream_player.stream = stream
	audio_stream_player.bus = "SFX"
	
	for prop in options.keys():
		audio_stream_player.set(prop, options[prop])
	
	audio_stream_player.play()
	audio_stream_player.finished.connect(kill.bind(audio_stream_player))
	
	return audio_stream_player
	
func kill(_audio_stream_player):
	_audio_stream_player.queue_free()
