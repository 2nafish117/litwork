extends Button

func _ready() -> void:
	var _throw = connect("pressed", self, "on_button_pressed")
	
func on_button_pressed():
	MinigameController.quit_minigame()
	pass
