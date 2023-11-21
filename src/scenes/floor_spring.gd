extends StaticBody2D
var is_on = false
var goup_ttl = 0
var char = null

func _physics_process(delta):
	if is_on:
		goup_ttl -= 1 * delta
		if goup_ttl <= 0:
			$sprite.position = $up.position
			char.mega_jump()
			is_on = false
	else:
		$sprite.position = lerp($sprite.position, $down.position, 0.1)
		if $sprite.position.distance_to($down.position) <= 0.1:
			$sprite.position = $down.position

func _on_char_detect_body_entered(body):
	if !is_on and body.is_in_group("npc") or body.is_in_group("interactuable"):
		char = body
		goup_ttl = 0.09
		is_on = true
