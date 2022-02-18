extends Button

export var next_scene: PackedScene 

func _ready() -> void:
	connect("pressed", self, "on_button_pressed")
	
func on_button_pressed():
	get_tree().change_scene_to(next_scene)
