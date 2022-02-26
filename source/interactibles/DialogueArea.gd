extends Area2D

signal dialogue_begin
signal dialogue_end

export(NodePath) var next_prompt: NodePath
export var active: bool = false
export var stop_for_dialogue: bool = true
export var begin_on_enter: bool = true
export var first_objective: bool = false
export(String, MULTILINE) var objective_text: String = ""

var player = null
var speechboxes: Array = [] 
var index = 0

func _ready() -> void:
	if first_objective:
		ObjectiveController.set_current_objective(self)
	for c in get_children():
		if c is SpeechBox:
			speechboxes.append(c)
			c.visible = false
			c.connect("speech_spoken", self, "_on_speech_spoken")

func _on_speech_spoken() -> void:
	if index == len(speechboxes):
		emit_signal("dialogue_end")
	if index < len(speechboxes):
		print(index)
		speechboxes[index].speak()
		index += 1

func _on_DialogueArea_dialogue_end() -> void:
	if player != null:
		var next = get_node_or_null(next_prompt)
		if next != null:
			# if ERROR: make sure next_prompt is of type DialogueArea or QuestionPromptArea!!!
			next.active = true
			ObjectiveController.set_current_objective(next)
		if stop_for_dialogue:
			player.movement_modifier = 1.0

func _process(_delta: float) -> void:
	if !active:
		return
	
	if begin_on_enter:
		if player != null:
			active = false
			if len(speechboxes) > 0:
				emit_signal("dialogue_begin")
				if stop_for_dialogue:
					player.movement_modifier = 0.0
				_on_speech_spoken()
			else:
				var next = get_node_or_null(next_prompt)
				if next != null:
					# if ERROR: make sure next_prompt is of type DialogueArea or QuestionPromptArea!!!
					next.active = true
	elif Input.is_action_just_pressed("action_interact"):
		if player != null and len(speechboxes) > 0:
			active = false
			if len(speechboxes) > 0:
				emit_signal("dialogue_begin")
				if stop_for_dialogue:
					player.movement_modifier = 0.0
				_on_speech_spoken()
			else:
				var next = get_node_or_null(next_prompt)
				if next != null:
					# if ERROR: make sure next_prompt is of type DialogueArea or QuestionPromptArea!!!
					next.active = true

func _on_DialogueArea_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		print("player in dialouge")
		player = body

func _on_DialogueArea_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		print("player out of dialouge")
		player = null
