extends MarginContainer

func ask_question(question: String, options: Array):
	$VBoxContainer/Question.text = question
	
	$VBoxContainer/HBoxContainerTop/OptionButton1.option_label = "A"
	$VBoxContainer/HBoxContainerTop/OptionButton1.option_text = options[0]

	$VBoxContainer/HBoxContainerTop/OptionButton2.option_label = "B"
	$VBoxContainer/HBoxContainerTop/OptionButton2.option_text = options[1]
	
	$VBoxContainer/HBoxContainerBottom/OptionButton3.option_label = "C"
	$VBoxContainer/HBoxContainerBottom/OptionButton3.option_text = options[2]
	
	$VBoxContainer/HBoxContainerBottom/OptionButton4.option_label = "D"
	$VBoxContainer/HBoxContainerBottom/OptionButton4.option_text = options[3]
