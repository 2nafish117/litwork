extends Area2D

signal dialogue_begin
signal dialogue_end

export(NodePath) var next_prompt: NodePath
export var active: bool = true
export var stop_for_dialogue: bool = true

var player = null
var speechboxes: Array = [] 
var index = 0

func _ready() -> void:
	for c in get_children():
		if c is SpeechBox:
			speechboxes.append(c)
			c.visible = false
			c.connect("speech_spoken", self, "_on_speech_spoken")

func _on_speech_spoken() -> void:
	if index < len(speechboxes):
		print(index)
		speechboxes[index].speak()
		if index == len(speechboxes) - 1:
			emit_signal("dialogue_end")
		index += 1

func _on_DialogueArea_dialogue_end() -> void:
	if player != null:
		var next = get_node_or_null(next_prompt)
		if next != null:
			# if ERROR: make sure next_prompt is of type DialogueArea or QuestionPromptArea!!!
			next.active = true
		if stop_for_dialogue:
			player.movement_modifier = 1.0

func _input(event: InputEvent) -> void:
	if active and player != null and event.is_action_pressed("action_interact"):
		active = false
		emit_signal("dialogue_begin")
		_on_speech_spoken()
		if stop_for_dialogue:
			player.movement_modifier = 0.0

func _on_DialogueArea_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		print("player in dialouge")
		player = body

func _on_DialogueArea_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		print("player out of dialouge")
		player = null
