extends Area2D

export(String, MULTILINE) var question: String

export(String, MULTILINE) var option_a: String
export(String, MULTILINE) var option_b: String
export(String, MULTILINE) var option_c: String
export(String, MULTILINE) var option_d: String

export(NodePath) var next_prompt: NodePath
export var active: bool = false setget set_active
export var first_objective: bool = false
export(String, MULTILINE) var objective_text: String = ""

func set_active(val: bool):
	active = val
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("player"):
			player = body
	pass
	
export var stop_for_question: bool = true

var player = null
onready var entry_audio = $EntryAudio
onready var exit_audio = $ExitAudio

func activate():
	active = true
	print("activated ", name, " [QuestionPromptArea]")

func _process(_delta: float) -> void:
	if !active:
		pass
		
	if player != null and active:
		if stop_for_question:
			player.movement_modifier = 0.0
		entry_audio.play(0.0)
		GlobalUi.ask_question(self, question, [option_a, option_b, option_c, option_d])

func _ready() -> void:
	if first_objective:
		ObjectiveController.set_current_objective(self)
	var _throw = GlobalUi.connect("question_answered", self, "on_question_answered")
	pass

func on_question_answered(area):
	if area == self and player != null:
		var next = get_node_or_null(next_prompt)
		if next != null:
			# if ERROR: make sure next_prompt is of type QuestionPromptArea!!!
			next.activate()
			ObjectiveController.set_current_objective(next)
		active = false
		exit_audio.play(0.0)
		if stop_for_question:
			player.movement_modifier = 1.0

func _on_QuestionPromptArea_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		print("player exit ", name, " [QuestionPromptArea]")
		player = null

func _on_QuestionPromptArea_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		print("player enter ", name, " [QuestionPromptArea]")
		player = body
