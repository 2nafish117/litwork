extends Control

export(String, FILE) var json_path

onready var question_label := $MarginContainer/HBoxContainer/Label
onready var button_container := $MarginContainer/HBoxContainer/Buttons
onready var option_a_button := button_container.get_node(@"OptionA")
onready var option_b_button := button_container.get_node(@"OptionB")
onready var option_c_button := button_container.get_node(@"OptionC")
onready var option_d_button := button_container.get_node(@"OptionD")

var questions: Array
var question_index := 0

func _ready() -> void:
	var file := File.new()
	var _throw = file.open(json_path, file.READ)
	var text = file.get_as_text()
	var result_json = JSON.parse(text)
	if result_json.error != OK:
		print("[load_json_file] Error loading JSON file '" + str(json_path) + "'.")
		print("\tError: ", result_json.error)
		print("\tError Line: ", result_json.error_line)
		print("\tError String: ", result_json.error_string)
		return
	var result = result_json.result
	
	for q in result["questions"]:
		questions.append(q)
	
	ask_next_question()
	
func ask_next_question():
	if len(questions) > 0 and question_index < len(questions):
		var q = questions[question_index]
		question_index += 1
		question_label.text = q["question"]
		option_a_button.option_text = q["a"]
		option_b_button.option_text = q["b"]
		option_c_button.option_text = q["c"]
		option_d_button.option_text = q["d"]
	else:
		MinigameController.quit_minigame()

func add_minigame_data_to_global():
	GlobalDetails.player_choices["minigame_hoax"]["questions"] = questions

func _on_OptionA_pressed() -> void:
	questions[question_index - 1]["player_choice"] = "a"
	ask_next_question()

func _on_OptionB_pressed() -> void:
	questions[question_index - 1]["player_choice"] = "b"
	ask_next_question()

func _on_OptionC_pressed() -> void:
	questions[question_index - 1]["player_choice"] = "c"
	ask_next_question()

func _on_OptionD_pressed() -> void:
	questions[question_index - 1]["player_choice"] = "d"
	ask_next_question()



