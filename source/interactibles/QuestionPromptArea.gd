extends Area2D

export(String, MULTILINE) var question: String

export(String, MULTILINE) var option_a: String
export(String, MULTILINE) var option_b: String
export(String, MULTILINE) var option_c: String
export(String, MULTILINE) var option_d: String

export(NodePath) var next_prompt: NodePath
export var active: bool = true setget set_active

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

func _process(delta: float) -> void:
	if player != null and active:
		if stop_for_question:
			player.movement_modifier = 0.0
		entry_audio.play(0.0)
		GlobalUi.ask_question(question, [option_a, option_b, option_c, option_d])
		set_physics_process(false)

func _ready() -> void:
	var _throw = GlobalUi.connect("question_answered", self, "on_question_answered")
	pass

func on_question_answered():
	if player != null:
		var next = get_node_or_null(next_prompt)
		if next != null:
			# if ERROR: make sure next_prompt is of type QuestionPromptArea!!!
			next.active = true
		active = false
		exit_audio.play(0.0)
		if stop_for_question:
			player.movement_modifier = 1.0

func _on_Spatial_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player = body
#		if stop_for_question:
#			body.movement_modifier = 0.0
#		entry_audio.play(0.0)
#		GlobalUi.ask_question(question, [option_a, option_b, option_c, option_d])


func _on_QuestionPromptArea_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		player = null