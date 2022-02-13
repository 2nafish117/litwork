extends CanvasLayer

onready var label := $MarginContainer/RichTextLabel

func _ready() -> void:
	GlobalTimer.start()

func format_time(secs: float) -> Array:
	var minutes = int(secs / 60.0)
	secs = int(fmod(secs, 60.0))
	return [minutes, secs]
	

func _process(delta: float) -> void:
	var t: Array = format_time(GlobalTimer.time_left)
	var minutes: int = t[0]
	var seconds: int = t[1]
	var time_string: String
	if minutes < 5:
		time_string = "[color=red]" + String(minutes) + ":" + String(seconds) + "[/color]"
	else:
		time_string = String(minutes) + ":" + String(seconds)
	label.bbcode_text = time_string
	pass
