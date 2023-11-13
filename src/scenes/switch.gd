extends Area2D
var is_on = true

func _ready():
	add_to_group("red_switch")

func _on_body_entered(body):
	if is_on and body.is_in_group("npc"):
		$sprite.frame = 1
		is_on = false
		var doors = get_tree().get_nodes_in_group("red_door") 
		for door in doors:
			door.open()
