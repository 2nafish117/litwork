extends CanvasLayer

onready var name_field := $MarginContainer/HBoxContainer/VBoxContainer/LineEdit
onready var email_field := $MarginContainer/HBoxContainer/VBoxContainer/LineEdit2
onready var sex_field := $MarginContainer/HBoxContainer/VBoxContainer/OptionButton

func _on_Button_pressed() -> void:
	GlobalDetails.player_info["name"] = name_field.text
	GlobalDetails.player_info["email"] = email_field.text
	GlobalDetails.player_info["sex"] = sex_field.get_item_text(sex_field.selected)
