extends CanvasLayer

signal question_answered

onready var label := $MarginContainer/RichTextLabel
onready var answer_options := $AnswerOptions

var current_question: String
var current_options: Array

func _ready() -> void:
	answer_options.visible = false
	pass
	
func format_time(secs: float) -> Array:
	var minutes = int(secs / 60.0)
	secs = int(fmod(secs, 60.0))
	return [minutes, secs]

func ask_question(question: String, options: Array):
	current_question = question
	current_options = options
	answer_options.visible = true
	answer_options.ask_question(question, options)
	pass

func _process(_delta: float) -> void:
	var t: Array = format_time(GlobalTimer.time_left)
	var minutes: int = t[0]
	var seconds: int = t[1]
	var time_string: String
	if minutes < 5:
		time_string = "[color=red]" + String(minutes).pad_zeros(2) + ":" + String(seconds).pad_zeros(2) + "[/color]"
	else:
		time_string = String(minutes) + ":" + String(seconds)
	label.bbcode_text = time_string
	pass


func _on_OptionButton1_pressed() -> void:
	print("option1")
	emit_signal("question_answered")
	answer_options.visible = false
	GlobalDetails.player_choices["questions_answers"].append({"question": current_question, "available_options": String(current_options), "chosen_option": current_options[0]})


func _on_OptionButton2_pressed() -> void:
	print("option2")
	emit_signal("question_answered")
	answer_options.visible = false
	GlobalDetails.player_choices["questions_answers"].append({"question": current_question, "available_options": String(current_options), "chosen_option": current_options[1]})


func _on_OptionButton3_pressed() -> void:
	print("option3")
	emit_signal("question_answered")
	answer_options.visible = false
	GlobalDetails.player_choices["questions_answers"].append({"question": current_question, "available_options": String(current_options), "chosen_option": current_options[2]})


func _on_OptionButton4_pressed() -> void:
	print("option4")
	emit_signal("question_answered")
	answer_options.visible = false
	GlobalDetails.player_choices["questions_answers"].append({"question": current_question, "available_options": String(current_options), "chosen_option": current_options[3]})
