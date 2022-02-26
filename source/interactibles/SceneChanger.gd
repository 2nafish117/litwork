extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var scene: PackedScene
var active = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if active  and event.is_action_pressed("action_interact"):
		var _throw = get_tree().change_scene_to(scene)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_SceneChanger_body_shape_entered(body_id, body, body_shape, local_shape):
		active =1
		pass # Replace with function body.


func _on_SceneChanger_body_shape_exited(body_id, body, body_shape, local_shape):
	active=0
	pass # Replace with function body.
