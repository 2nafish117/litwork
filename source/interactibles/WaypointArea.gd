extends Area2D

signal dialogue_begin
signal dialogue_end

export(NodePath) var next_prompt: NodePath
export var active: bool = false
export var first_objective: bool = false

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
			next.active = true
			ObjectiveController.set_current_objective(next)

func _on_WaypointArea_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		print("player entered waypoint")
		player = body

func _on_WaypointArea_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		print("player entered waypoint")
		player = null
