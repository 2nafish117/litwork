extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var option2 = get_node("/root/Hoax")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func option2_text(o):
	self.text = str(o)
