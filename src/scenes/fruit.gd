extends Area2D
var is_on = true
var speed = 89
var rotate_dir = 1
var rotate_ttl_total = 0.3
var rotate_ttl = rotate_ttl_total

func _ready():
	Global.TOTAL_FRUITS += 1

func _physics_process(delta):
	rotate_ttl -= 1 * delta
	if rotate_ttl <= 0:
		rotate_ttl = rotate_ttl_total
		rotate_dir *= -1
	
	$sprite.rotation_degrees += (speed * rotate_dir) * delta

func _on_body_entered(body):
	if is_on and body.is_in_group("npc"):
		is_on = false
		Global.FRUITS += 1
		if Global.level_name == "Level0":
			Global.next_tutorial()
		if Global.FRUITS >= Global.TOTAL_FRUITS:
			Global.PORTAL.set_on()
			
		visible = false
