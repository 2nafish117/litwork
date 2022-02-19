tool
class_name SpeechBox
extends NinePatchRect

signal speech_spoken

export(String, MULTILINE) var bb_text: String setget set_bb_text, get_bb_text
export var speak_rate: float = 1.0

var speaking: bool = false

onready var audio := $AudioStreamPlayer

func _ready() -> void:
	# testing
	# speak()
	pass

func speak():
	visible = true
	speaking = true
	var num_chars := len(bb_text)
	$Tween.stop_all()
	$Tween.interpolate_property($MarginContainer/VBoxContainer/RichTextLabel, "visible_characters", 0, num_chars, num_chars / speak_rate, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	audio.play(0.0)

func set_bb_text(val: String):
	bb_text = val
	if has_node("MarginContainer/VBoxContainer/RichTextLabel"):
		$MarginContainer/VBoxContainer/RichTextLabel.bbcode_text = val
	
func get_bb_text() -> String:
	return bb_text
	
func _input(event: InputEvent) -> void:
	if speaking and $Tween.is_active() and event.is_action_pressed("action_interact"):
		$Tween.stop_all()
		$MarginContainer/VBoxContainer/RichTextLabel.visible_characters = -1
		pass
	elif speaking and !$Tween.is_active() and event.is_action_pressed("action_interact"):
		print("speech spoken")
		get_tree().set_input_as_handled()
		emit_signal("speech_spoken")
		$Tween.stop_all()
		visible = false
		speaking = false
