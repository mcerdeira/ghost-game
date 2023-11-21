extends Area2D
var is_on = true
var bodies = []

func _ready():
	add_to_group("red_switch")
	
func _physics_process(delta):
	var areas = get_overlapping_areas()
	var fire_count = 0
	for area in areas:
		if area.is_in_group("fire_particle"):
			fire_count = 1
			break
	
	if fire_count == 0 and is_on:
		is_on = false
		$sprite.frame = 0
		var doors = get_tree().get_nodes_in_group("fire_door") 
		for door in doors:
			door.close()
	elif fire_count > 0 and !is_on:
		is_on = true
		$sprite.frame = 1
		var doors = get_tree().get_nodes_in_group("fire_door") 
		for door in doors:
			door.open()
