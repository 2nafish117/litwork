extends Area2D

signal dialogue_begin
signal dialogue_end

export(NodePath) var next_prompt: NodePath
export var active: bool = false
export var first_objective: bool = false
export(String, MULTILINE) var objective_text: String = ""
export(NodePath) var elevator_path: NodePath
export var active_floor: int

var player = null

func _ready() -> void:
	if first_objective:
		ObjectiveController.set_current_objective(self)

func _process(delta: float) -> void:
	if !active:
		return
	
	if player != null:
		active = false
		var next = get_node_or_null(next_prompt)
		if next != null:
			# if ERROR: make sure next_prompt is of type DialogueArea or QuestionPromptArea!!!
			next.activate()
#			next.active = true
#			if next.has_method("set_elevator_restriction"):
#				next.set_elevator_restriction()
			ObjectiveController.set_current_objective(next)

func activate():
	active = true
	set_elevator_restriction()

func set_elevator_restriction():
	if !elevator_path.is_empty():
		var elevator: Node2D = get_node_or_null(elevator_path)
		if elevator != null:
			print("elevator restricted to ", active_floor)
			elevator.restrict_to_floor(active_floor)

func _on_WaypointArea_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		print("player entered waypoint")
		player = body

func _on_WaypointArea_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		print("player entered waypoint")
		player = null
