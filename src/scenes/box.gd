extends CharacterBody2D
var gravity = 10.0
var speed = 75.0
var jump_speed = -300.0
var grabbed = false
var total_friction = 0.3
var friction = total_friction

func _ready():
	add_to_group("interactuable")
	
func pushed(force, direction):
	if direction == "left":
		force = -force
		
	velocity.x = force
	
func _physics_process(delta):
	if !grabbed:
		if !is_on_floor():
			velocity.y += gravity
			
		velocity.x = lerp(velocity.x, 0.0, friction)
		if abs(velocity.x) <= 0.0:
			velocity.x = 0.0
			friction = total_friction
			
		move_and_slide()
	else:
		$collider.set_deferred("disabled", true)
		velocity.x = 0
		velocity.y = 0
	
func mega_jump():
	Global.play_sound(Global.SPRING_SFX)
	velocity.y = jump_speed * 2
	
func little_jump():
	Global.play_sound(Global.JUMP_SFX)
	velocity.y = jump_speed / 2
	
func droped(speed, direction):
	$collider.set_deferred("disabled", false)
	velocity.y = jump_speed
	friction = 0.02
	pushed(speed * 2, direction)
	
func teleport(pos):
	global_position = pos
