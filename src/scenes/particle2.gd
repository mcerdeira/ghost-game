extends GPUParticles2D
var clear_ttl = 2


func _physics_process(delta):
	if !emitting:
		clear_ttl -= 1 * delta
		if clear_ttl <= 0:
			queue_free()

func _on_timer_timeout():
	emitting = false
