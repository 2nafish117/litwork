extends Area2D

signal speech_begun
signal speech_spoken

export(String, MULTILINE) var speech: String
export(NodePath) var next_prompt: NodePath
export var active: bool = true
export var stop_for_speech: bool = true

var player = null

func _ready() -> void:
	#GlobalUi.connect("speech_spoken", self, "on_speech_spoken")
	pass

func _on_SpeechArea_body_entered(body: Node) -> void:
	if body.is_in_group("player") and active:
		player = body
		player.speak(speech, 0.0)
		player.connect("speech_spoken", self, "_on_SpeechArea_speech_spoken")
		emit_signal("speech_begun")
		if stop_for_speech:
			body.movement_modifier = 0.0

func _on_SpeechArea_speech_spoken() -> void:
	if player != null:
		var next = get_node_or_null(next_prompt)
		if next != null:
			# if ERROR: make sure next_prompt is of type SpeechArea or QuestionPromptArea!!!
			next.active = true
		active = false
		if stop_for_speech:
			player.movement_modifier = 1.0
