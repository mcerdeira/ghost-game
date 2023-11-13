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
