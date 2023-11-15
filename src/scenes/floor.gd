extends StaticBody2D
var where = null

func _ready():
	add_to_group("red_door")
	
func _physics_process(delta):
	if where:
		$sprite.position = lerp($sprite.position, where.position, 0.1)
		if $sprite.position.distance_to(where.position) <= 0.1:
			$sprite.position = where.position
			where = null
		$collision.position = $sprite.position

func open():
	where = $down

func close():
	where = $up

