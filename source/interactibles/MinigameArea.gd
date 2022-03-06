extends Area2D

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
	var _throw = MinigameController.connect("minigame_end", self, "on_minigame_end")

func _process(_delta: float) -> void:
	if !active:
		return
	
	if begin_on_enter:
		if player != null:
			active = false
			if stop_for_minigame:
				player.movement_modifier = 0.0
			MinigameController.start_minigame(minigame)
	elif Input.is_action_just_pressed("action_interact"):
		if player != null:
			active = false
			if stop_for_minigame:
				player.movement_modifier = 0.0
			MinigameController.start_minigame(minigame)

func activate():
	active = true
	print("activated ", name, " [MinigameArea]")

func on_minigame_end() -> void:
	if player != null:
		if stop_for_minigame:
			player.movement_modifier = 1.0
		var next: Node2D = get_node_or_null(next_prompt)
		if next != null:
			# if ERROR: make sure next_prompt is of type DialogueArea or QuestionPromptArea!!!
			next.activate()
			ObjectiveController.set_current_objective(next)

func _on_MinigameArea_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		print("player enter ", name, " [MinigameArea]")
		player = body

func _on_MinigameArea_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		print("player exit ", name, " [MinigameArea]")
		player = null
