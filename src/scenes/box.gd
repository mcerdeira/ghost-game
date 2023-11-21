extends CharacterBody2D
var gravity = 10.0
var speed = 75.0
var jump_speed = -300.0

func _ready():
	add_to_group("interactuable")
	
func pushed(force, direction):
	if direction == "left":
		force = -force
		
	velocity.x = force
	
func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity
		
	velocity.x = lerp(velocity.x, 0.0, 0.3)
	move_and_slide()
	
func mega_jump():
	velocity.y = jump_speed * 2
	
func teleport(pos):
	global_position = pos
