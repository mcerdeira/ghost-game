extends Area2D
var speed = 98
var total_ttl = 0.6
var ttl = 0
var initial_pos = null
var red = Color(1.0, 0, 0, 1)
var yellow = Color(1.0, 0.88, 0, 1)
var orange = Color(1.0, 0.43, 0, 1)
var grey = Color(0.55, 0.55, 0.55, 1)

func _ready():
	add_to_group("fire_particle")
	ttl = randi() % 2
	rando()
	speed = speed * (randi() % 5)
	initial_pos = position
	
func rando():
	var alpha = randf()
	$sprite.modulate = Global.pick_random([red, yellow, orange, grey])
	$sprite.modulate.a = alpha
	scale.x = Global.pick_random([1, 1.5, 2, 0.5])
	scale.y = scale.x

func _physics_process(delta):
	$sprite.rotation_degrees += (randi() % 180) * Global.pick_random([1, -1])
	position.x += Global.pick_random(range(8)) * Global.pick_random([1, -1])
	position.y -= speed * delta
	ttl -= 1 * delta
	if ttl <= 0:
		rando()
		ttl = total_ttl
		position = initial_pos

func _on_body_entered(body):
	ttl = 0
