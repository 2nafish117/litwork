tool
extends NinePatchRect

signal speech_spoken

export(String, MULTILINE) var bb_text: String setget set_bb_text, get_bb_text

func speak(text: String, time: float):
	set_bb_text(text)
	$Tween.interpolate_property($MarginContainer/RichTextLabel, "visible_charecters", 0, len(text), time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func set_bb_text(val: String):
	bb_text = val
	if has_node("MarginContainer/RichTextLabel"):
		$MarginContainer/RichTextLabel.bbcode_text = val
	
func get_bb_text() -> String:
	return bb_text

func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
	emit_signal("speech_spoken")
