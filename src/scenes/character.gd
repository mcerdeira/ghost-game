extends CharacterBody2D
var mode = "npc"
var gravity = 10.0
var speed = 75.0
var jump_speed = -300.0
var direction = "right"
var absorved_ttl = 0
var is_absorved = false
var first_time = true

@export var type = Global.npc_types.NONE
var state = Global.npc_states.IDLE
var idle_timer_total = 5
var idle_timer = idle_timer_total

func _ready():
	add_to_group("interactuable")
	add_to_group("npc")
	set_sprite()

func _physics_process(delta):
	if Global.WIN:
		if is_absorved:
			if absorved_ttl > 0:
				absorved_ttl -= 1 * delta
			elif absorved_ttl <= 0:
				$sprite.rotation_degrees += 200 * delta
				$sprite.scale.x = lerp($sprite.scale.x, 0.0, 0.01)
				$sprite.scale.y = $sprite.scale.x 
	
	if !is_on_floor():
		velocity.y += gravity
		
	velocity.x = 0
	
	if is_absorved:
		velocity.x = 0
		velocity.y = 0
	
	if mode == "npc":
		process_npc(delta)
	elif mode == "player":
		process_player(delta)
		
	move_and_slide()
	
func change_mode(_mode):
	first_time = true
	mode = _mode

func process_npc(delta):
	if type == Global.npc_types.WALKY:
		idle_timer = 0
	
	if first_time and type == Global.npc_types.SLEEPY:
		first_time = false
		idle_timer = 0.1
	
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
	if !Global.WIN:
		var moving = false
		if Input.is_action_just_pressed("jump"):
			if type != Global.npc_types.WALKY:
				do_action(delta)
			
		if Input.is_action_pressed("left"):
			direction = "left"
			moving = true
			velocity.x = -speed
			$sprite.scale.x = -1
			un_sleep()
		elif Input.is_action_pressed("right"):
			direction = "right"
			moving = true
			velocity.x = speed
			$sprite.scale.x = 1
			un_sleep()
			
		if moving:
			$sprite.play()
		else:
			$sprite.stop()
	
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
		
func absorved():
	is_absorved = true
	absorved_ttl = 0.1
		
func do_action(delta):
	if !Global.WIN:
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
	if is_on_floor():
		velocity.y = jump_speed
	
func mega_jump():
	if is_on_floor():
		velocity.y = jump_speed * 2
	
func sleep(delta):
	$Sleep.visible = true
	$SleepAnimation.play("new_animation")
	
func un_sleep():
	$Sleep.visible = false
	$SleepAnimation.stop(false)
	
func swap_direction():
	if direction == "left":
		return "right"
	else:
		return "left"
	
func walk(delta):
	var moving = false
	if is_on_wall():
		direction = swap_direction()
	
	if direction == "left":
		moving = true
		if is_on_floor():
			velocity.x = -speed
		else:
			velocity.x = -(speed / 2)
		$sprite.scale.x = -1
	elif direction == "right":
		moving = true
		if is_on_floor():
			velocity.x = speed
		else:
			velocity.x = (speed / 2)
		$sprite.scale.x = 1
		
	if moving:
		$sprite.play()
	else:
		$sprite.stop()
	
func push(delta, node):
	pass
	
func grab(delta, node):
	pass
	
func shoot(delta, type):
	pass
	
func _on_mouse_rec_input_event(viewport, event, shape_idx):
	if mode == "npc" and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		if Global.level_name == "Level0":
			Global.next_tutorial("right-click")
		
		mode = "player"
		Global.play_sound(Global.POSSES_SFX)
		Global.GHOST.set_possesed(self)
		get_tree().paused = true
