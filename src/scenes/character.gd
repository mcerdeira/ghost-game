extends Node2D
var mode = ""
@export var type = Global.npc_types.NONE
var state = Global.npc_states.IDLE
var idle_timer_total = 5
var idle_timer = idle_timer_total

func _ready():
	add_to_group("npc")
	set_sprite()

func _process(delta):
	if mode == "npc":
		process_npc(delta)
	elif mode == "player":
		process_player(delta)

func process_npc(delta):
	if state == Global.npc_states.IDLE:
		idle_timer -= 1 * delta
		if idle_timer <= 0:
			idle_timer = idle_timer_total
			do_action(delta)
		
	if state == Global.npc_states.INLOVE:
		pass
	if state == Global.npc_states.INLOVE_CHASE:
		pass
	if state == Global.npc_states.ANGRY:
		pass
	
func process_player(delta):
	pass
	
func set_sprite():
	if type == Global.npc_types.FLAMY:
		pass
	if type == Global.npc_types.JUMPY:
		pass
	if type == Global.npc_types.GRABY:
		pass
	if type == Global.npc_types.PUSHY:
		pass
	if type == Global.npc_types.SLEEPY:
		pass
	if type == Global.npc_types.WALKY:
		pass
		
func do_action(delta):
	if type == Global.npc_types.FLAMY:
		shoot(delta, "fire")
	if type == Global.npc_types.JUMPY:
		jump(delta)
	if type == Global.npc_types.GRABY:
		pass
	if type == Global.npc_types.PUSHY:
		pass
	if type == Global.npc_types.SLEEPY:
		sleep(delta)
	if type == Global.npc_types.WALKY:
		walk(delta)

func jump(delta):
	pass
	
func sleep(delta):
	pass
	
func walk(delta):
	pass
	
func push(delta, node):
	pass
	
func grab(delta, node):
	pass
	
func shoot(delta, type):
	pass
