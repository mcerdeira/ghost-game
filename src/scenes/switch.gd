extends Area2D
var is_on = true
var bodies = []

func _ready():
	add_to_group("red_switch")
	
func _physics_process(delta):
	var things = get_overlapping_areas()

func _on_body_entered(body):
	if is_on and body.is_in_group("npc") or body.is_in_group("interactuable"):
		bodies.push_back(body)
		$sprite.frame = 1
		is_on = false
		var doors = get_tree().get_nodes_in_group("red_door") 
		for door in doors:
			door.open()


func _on_body_exited(body):
	if !is_on and body.is_in_group("npc") or body.is_in_group("interactuable"):
		bodies.erase(body)
		if bodies.size() <= 0:
			$sprite.frame = 0
			is_on = true
			var doors = get_tree().get_nodes_in_group("red_door") 
			for door in doors:
				door.close()
