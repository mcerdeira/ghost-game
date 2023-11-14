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
var LEVEL = 0
var TUTORIALS = [
	"[CLIK TO MOVE THE GHOST AROUND]",
	"[CLIK TO MOVE THE GHOST AROUND]",
	"[RIGHT CLICK ON OTHERS TO POSSES]",
	"[CONTROL THE POSSESSED BODY]",
	"[GET ALL THE FRUITS TO UNLOCK THE PORTAL\nAND EXIT LEVEL THROUGH ACTIVED PORTAL]",
]

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

func _ready():
	pass

func _process(delta):
	pass
