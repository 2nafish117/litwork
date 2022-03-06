extends Control

onready var degree := $MarginContainer/HBoxContainer/VBoxContainer/Degree

onready var score_type := $MarginContainer/HBoxContainer/VBoxContainer/HSplitContainer3/ScoreType
onready var score_value := $MarginContainer/HBoxContainer/VBoxContainer/HSplitContainer3/SpinBox

onready var graduation_date := $MarginContainer/HBoxContainer/VBoxContainer/HSplitContainer/GraduationYear

onready var qualification := $MarginContainer/HBoxContainer/VBoxContainer/Qualification

onready var specialization := $MarginContainer/HBoxContainer/VBoxContainer/Specialization

onready var work_expirience := $MarginContainer/HBoxContainer/VBoxContainer/HSplitContainer2/WorkExpirience

export(String, FILE) var json_path

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
	
	for q in result["qualification"]:
		qualification.add_item(q)
		
	for d in result["degree"]:
		degree.add_item(d)
		
	for s in result["specialization"]:
		specialization.add_item(s)
		
	for s in result["score_type"]:
		score_type.add_item(s)
