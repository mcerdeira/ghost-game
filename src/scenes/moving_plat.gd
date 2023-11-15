extends AnimatableBody2D
var where = null
var opened = false
var ttl_total = 1.1
var ttl = ttl_total

func _ready():
	add_to_group("moving_platform")
#	open()
#
#func _physics_process(delta):
#	if ttl <= 0:
#		$sprite.position = lerp($sprite.position, where.position, 0.1)
#		if $sprite.position.distance_to(where.position) <= 0.1:
#			$sprite.position = where.position
#			open()
#		$collision.position = $sprite.position
#	else:
#		ttl -= 1 * delta
#
#func open():
#	if !opened:
#		where = $down
#	else:
#		where = $up
#	ttl = ttl_total
#	opened = !opened

