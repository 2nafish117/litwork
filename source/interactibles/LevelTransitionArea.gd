extends Area2D

export var scene: PackedScene

func _on_LevelTransitionArea_body_entered(body: Node) -> void:
	if body.is_in_group("player") and scene != null:
		get_tree().change_scene_to(scene)
