extends Node2D
var fire_part_obj = preload("res://scenes/fire_part.tscn")
var total_part = 106
var inside_me = []
var created = false

func _ready():
	create()
		
func create():
	for i in range(total_part):
		var f = fire_part_obj.instantiate()
		add_child(f)
	
	created = true
	
func destroy():
	var fires = get_children()
	for f in fires:
		if f.is_in_group("fire_particle"):
			f.queue_free()
			
	created = false
		
func _physics_process(delta):
	if inside_me.size() == 0 and !created:
		create()
	elif inside_me.size() > 0 and created:
		destroy()

func _on_inhiber_body_entered(body):
	if body.is_in_group("interactuable") and body not in inside_me:
		inside_me.push_back(body)

func _on_inhiber_body_exited(body):
	if body.is_in_group("interactuable") and body in inside_me:
		inside_me.erase(body)
