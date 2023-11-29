extends Area2D
var inside_me = []
@export var _teleporter : NodePath
@onready var teleporter : Area2D = get_node(_teleporter) as Area2D

func _ready():
	$GPUParticles2D.gravity = Vector2(980 * -scale.x, 0)

func _on_body_entered(body):
	if body.is_in_group("interactuable") and body not in inside_me:
		Global.emit(global_position, 1)
		teleporter.inside_me.push_back(body)
		body.teleport(teleporter.global_position)

func _on_body_exited(body):
	if body.is_in_group("interactuable") and body in inside_me:
		Global.emit(global_position, 1)
		inside_me.erase(body)
