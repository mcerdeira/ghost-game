extends Node
enum npc_states {IDLE, ANGRY, INLOVE, INLOVE_CHASE}
enum npc_types {NONE, JUMPY, SLEEPY, WALKY, PUSHY, GRABY, FLAMY}
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
var POSSES_SFX = null

var MUSIC_PLAYING = false
var MainTheme = "res://music/Bone Yard Waltz - Loopable.ogg"
var TUTORIALS = [
	"[CLICK TO MOVE THE GHOST AROUND]",
	"[RIGHT CLICK ON OTHERS TO POSSES]",
	"[CONTROL THE POSSESSED BODY (WASD/SPACE)]",
	"[GET ALL THE FRUITS TO UNLOCK THE PORTAL\nAND EXIT LEVEL THROUGH ACTIVED PORTAL]",
]

var CHARS_DATA = [{
},
{
	"title": "JUMPY",
	"description": "Jumps around like a rabbit.",
},
{
	"title": "SLEEPY",
	"description": "Falls asleep and does nothing.",
},
{
	"title": "WALKY",
	"description": "Walks from right to left and left to right.",
}
,
{
	"title": "PUSHY",
	"description": "Can push some boxes and other things.",
}
,
{
	"title": "GRABY",
	"description": "Can grab and throw stuff.",
}
,
{
	"title": "FLAMY",
	"description": "Spits fire like a dragon.",
}
]

var LEVELS = [
	"res://scenes/levels/level0.tscn",
	"res://scenes/levels/level1.tscn",
	"res://scenes/levels/level2.tscn",
	"res://scenes/levels/level3.tscn"
]

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	POSSES_SFX = preload("res://sfx/172206__fins__teleport.wav")

func next_tutorial():
	Global.tutorial_lbl.text = Global.TUTORIALS[Global.tutorial_index]
	Global.tutorial_index += 1
	if Global.tutorial_index > Global.TUTORIALS.size() - 1:
		Global.tutorial_index = 0

func init():
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
