extends Node2D
var fire_part_obj = preload("res://scenes/fire_part.tscn")
var total_part = 106

func _ready():
	for i in range(total_part):
		var f = fire_part_obj.instantiate()
		
		add_child(f)
