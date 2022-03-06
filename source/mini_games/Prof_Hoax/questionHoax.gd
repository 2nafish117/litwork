extends Label

onready var question = get_node("/root/Hoax")

func _ready():
	pass
func label_update(r):
	
	self.text = str(r)

