extends CharacterBody2D
var grabbed = false
var mode = "npc"
var gravity = 10.0
var speed = 75.0
var jump_speed = -300.0
@export var direction = "right"
var absorved_ttl = 0
var is_absorved = false
var push_force = 80.0
var grabed_obj = null
var total_friction = 0.3
var friction = total_friction
var emit_ttl = 0
var grab_ttl_total = 1
var grab_ttl = grab_ttl_total

@export var type = Global.npc_types.NONE
var state = Global.npc_states.IDLE
var idle_timer_total = 5
var idle_timer = idle_timer_total

func _ready():
	$counter.visible = false
	add_to_group("interactuable")
	add_to_group("npc")
	set_sprite()
	set_collider()
	if type == Global.npc_types.FAKE:
		mode = "player"
		Global.GHOST.possesing = false
		Global.GHOST.visible = false
		Global.GHOST.possed_char = self
		Global.IN_OTHER = true
	
func teleport(pos):
	global_position = pos
	
func pushed(force, _direction):
	if _direction == "left":
		force = -force
		
	velocity.x = force
	
func droped(speed, direction):
	grabbed = false
	velocity.y = jump_speed
	friction = 0.02
	pushed(speed * 2, direction)

func _physics_process(delta):
	if grabbed:
		$sprite.stop()
		velocity.x = 0
		velocity.y = 0
		return 
			
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
	else:
		if state == Global.npc_states.WORKING and type == Global.npc_types.JUMPY:
			state = Global.npc_states.IDLE
		
		if friction != total_friction:
			friction = lerp(friction, total_friction, 0.01)
		
	velocity.x = lerp(velocity.x, 0.0, friction)
	
	if emit_ttl > 0:
		emit_ttl -= 1 * delta
		if randi() % 7 == 0:
			Global.emit(global_position, 1)
	
	if is_absorved:
		velocity.x = 0
		velocity.y = 0
	
	if mode == "npc":
		process_npc(delta)
	elif mode == "player":
		process_player(delta)
		
	move_and_slide()
	
	if type == Global.npc_types.PUSHY:
		var slide_col = get_slide_collision_count()
		var push_something = false
		for i in slide_col:
			var c = get_slide_collision(i)
			var col = c.get_collider() 
			var normal = c.get_normal()
			if col.is_in_group("interactuable") and normal.y == 0:
				push_something = true
				col.pushed(speed, direction)
		if push_something:
			$sprite.animation = "pushyp"
		else:
			$sprite.animation = "pushy"
	
func change_mode(_mode):
	$counter.visible = false
	state = Global.npc_states.IDLE
	mode = _mode
	if mode == "player":
		emit_ttl = 0.2

func process_npc(delta):
	if type != Global.npc_types.FAKE:
		if state == Global.npc_states.IDLE:
			if !$CounterAnimation.is_playing():
				state = Global.npc_states.COUNTING
				$counter.visible = true	
				$CounterAnimation.play("new_animation")
				
		if state == Global.npc_states.COUNTING:
			if !$CounterAnimation.is_playing():
				if type == Global.npc_types.GRABY:
					grab_ttl = grab_ttl_total
				do_action(delta)
				
	if grab_ttl > 0 and state == Global.npc_states.WORKING and type == Global.npc_types.GRABY:
		do_action(delta)
		grab_ttl -= 1 * delta
		if grab_ttl <= 0:
			$sprite.animation = "graby"
			state = Global.npc_states.IDLE
			
func process_player(delta):
	if !Global.WIN:
		var moving = false
		if grab_ttl > 0 and state == Global.npc_states.WORKING and type == Global.npc_types.GRABY:
			grab_ttl -= 1 * delta
			do_action(delta)
			if grab_ttl <= 0:
				$sprite.animation = "graby"
				state = Global.npc_states.IDLE
		
		if Input.is_action_just_pressed("jump"):
			if type != Global.npc_types.WALKY and type != Global.npc_types.PUSHY:
				do_action(delta)
			
		if Input.is_action_pressed("left"):
			direction = "left"
			if $sprite.scale.x == 1:
				set_collider()
			moving = true
			velocity.x = -speed
			$sprite.scale.x = -1
			un_sleep()
		elif Input.is_action_pressed("right"):
			direction = "right"
			if $sprite.scale.x == -1:
				set_collider()
			moving = true
			velocity.x = speed
			$sprite.scale.x = 1
			un_sleep()
			
		if moving:
			if type == Global.npc_types.GRABY:
				if $sprite.animation == "grabyG":
					$sprite.animation = "graby"
			
			$sprite.play()
		else:
			$sprite.stop()
	
func set_sprite():
	if type == Global.npc_types.FLAMY:
		$sprite.animation = "flamy"
	if type == Global.npc_types.JUMPY:
		$sprite.animation = "jumpy"
	if type == Global.npc_types.GRABY:
		$sprite.animation = "graby"
	if type == Global.npc_types.PUSHY:
		$sprite.animation = "pushy"
	if type == Global.npc_types.SLEEPY:
		$sprite.animation = "sleepy"
	if type == Global.npc_types.WALKY:
		$sprite.animation = "walky"
		
func absorved():
	is_absorved = true
	absorved_ttl = 0.1
		
func do_action(delta):
	if !Global.WIN:
		if type == Global.npc_types.FLAMY:
			shoot(delta, "fire")
		if type == Global.npc_types.JUMPY or type == Global.npc_types.FAKE:
			jump(delta)
		if type == Global.npc_types.GRABY:
			grab()
		if type == Global.npc_types.PUSHY:
			walk(delta)
		if type == Global.npc_types.SLEEPY:
			sleep(delta)
		if type == Global.npc_types.WALKY:
			walk(delta)

func jump(delta):
	if is_on_floor() and !grabbed:
		state = Global.npc_states.WORKING
		Global.play_sound(Global.JUMP_SFX)
		Global.emit(global_position, 2)
		velocity.y = jump_speed
	
func mega_jump():
	if !grabbed:
		Global.play_sound(Global.SPRING_SFX)
		velocity.y = jump_speed * 2
	
func little_jump():
	if !grabbed:
		Global.play_sound(Global.JUMP_SFX)
		velocity.y = jump_speed / 2
	
func sleep(delta):
	state == Global.npc_states.WORKING
	$sprite.stop()
	$Sleep.visible = true
	$SleepAnimation.play("new_animation")
	
func un_sleep():
	state == Global.npc_states.IDLE
	$Sleep.visible = false
	$SleepAnimation.stop(false)
	
func set_collider():
	if type == Global.npc_types.GRABY:
		if direction == "left":
			$grab_area/collider_L.set_deferred("disabled", false)
			$grab_area/collider_R.set_deferred("disabled", true)
		else:
			$grab_area/collider_L.set_deferred("disabled", true)
			$grab_area/collider_R.set_deferred("disabled", false)

func swap_direction():
	set_collider()
	if direction == "left":
		return "right"
	else:
		return "left"
	
func walk(delta):
	state == Global.npc_states.WORKING
	var moving = false
	if type == Global.npc_types.WALKY:
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
	
func grab():
	if grabed_obj == null:
		state = Global.npc_states.WORKING
		var areas = $grab_area.get_overlapping_bodies()
		$sprite.animation = "grabyG"
		for area in areas:
			if area.is_in_group("interactuable"):
				state = Global.npc_states.IDLE
				grabed_obj = area
				area.grabbed = true
				get_parent().remove_child(area)
				add_child(area)
				$sprite.animation = "grabyu"
				area.position.x = 0
				area.position.y = -35
				
	else:
		state = Global.npc_states.IDLE
		grabed_obj.grabbed = false
		$sprite.animation = "graby"
		remove_child(grabed_obj)
		get_parent().add_child(grabed_obj)
		grabed_obj.global_position.x = global_position.x
		grabed_obj.global_position.y = global_position.y - 30
		
		grabed_obj.droped(speed, direction)
		grabed_obj = null
	
func shoot(delta, type):
	pass
	
func _on_mouse_rec_input_event(viewport, event, shape_idx):
	if Global.level_name != "LevelIntro":
		if mode == "npc" and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
			if Global.level_name == "Level0":
				Global.next_tutorial("right-click")
			
			Global.emit(global_position, 2)
			mode = "player"
			Global.play_sound(Global.POSSES_SFX)
			Global.GHOST.set_possesed(self)
			get_tree().paused = true
