extends Area2D

export var from: NodePath
export var to: NodePath

func _on_SwitchCameraArea_body_entered(body: Node) -> void:
	if body.is_in_group("player") and !to.is_empty() and !from.is_empty():
		body
