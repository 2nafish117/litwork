extends Area2D

signal minigame_begin
signal minigame_end

export(NodePath) var next_prompt: NodePath
export var active: bool = false
export var stop_for_minigame: bool = true
export var begin_on_enter: bool = false
export(PackedScene) var minigame: PackedScene
export var first_objective: bool = false
export(String, MULTILINE) var objective_text: String = ""

var player = null

func _ready() -> void:
	if first_objective:
		ObjectiveController.set_current_objective(self)
	MinigameController.connect("minigame_end", self, "on_minigame_end")

func _process(_delta: float) -> void:
	if !active:
		return
	
	if begin_on_enter:
		if player != null:
			active = false
			if stop_for_minigame:
				player.movement_modifier = 0.0
			emit_signal("minigame_begin")
	elif Input.is_action_just_pressed("action_interact"):
		if player != null:
			active = false
			if stop_for_minigame:
				player.movement_modifier = 0.0
			emit_signal("minigame_begin")

func _on_MinigameArea_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		print("player in minigame")
		player = body

func _on_MinigameArea_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		print("player out of minigame")
		player = null

func activate():
	active = true

func on_minigame_end() -> void:
	emit_signal("minigame_end")
	if player != null and stop_for_minigame:
		player.movement_modifier = 1.0
	var next = get_node_or_null(next_prompt)
	if next != null:
		# if ERROR: make sure next_prompt is of type DialogueArea or QuestionPromptArea!!!
		next.activate()
		ObjectiveController.set_current_objective(next)


func _on_MinigameArea_minigame_begin() -> void:
	MinigameController.start_minigame(minigame)
