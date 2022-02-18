tool
extends TextureButton

export(String, MULTILINE) var option_label: String setget set_option_label, get_option_label
export(String, MULTILINE) var option_text: String setget set_option_text, get_option_text

func set_option_label(val: String):
	option_label = val
	if has_node("OptionLabel"):
		$OptionLabel.text = val
	
func get_option_label():
	return option_label

func set_option_text(val: String):
	option_text = val
	if has_node("OptionText"):
		$OptionText.text = val
	
func get_option_text():
	return option_text
