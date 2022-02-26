extends Node2D

var current_objective: Node2D
var marker: Node2D = null

func set_marker(_marker: Node2D):
	marker = _marker

func set_current_objective(obj: Node2D):
	current_objective = obj
	if marker != null:
		marker.objective = obj
		if "objective_text" in obj:
			GlobalUi.set_objective_text(obj.objective_text)
