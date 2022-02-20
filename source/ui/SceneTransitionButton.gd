extends Button

export var next_scene: PackedScene 

func _ready() -> void:
	var _throw = connect("pressed", self, "on_button_pressed")
	
func on_button_pressed():
	var _throw = get_tree().change_scene_to(next_scene)
