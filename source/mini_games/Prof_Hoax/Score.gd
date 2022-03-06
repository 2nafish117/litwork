extends Label

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var visits = get_node("/root/visits")
onready var score = get_node("/root/HoaxGlobal")
# Called when the node enters the scene tree for the first time.

func _process(delta):
	text = str(score.score)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func scoreupdate():
	text = str(score.score)

func _on_Quit_pressed():
	if visits.player == 1:
		var dialogue3 = Dialogic.start("DeskEmail02")
		add_child(dialogue3)
	elif visits.player == 2:
		var dialogue1 = Dialogic.start("DeskEmail02_F")
		add_child(dialogue1)
	#get_parent().queue_free()
	pass # Replace with function body.


func _on_Quit_tree_exiting():
	get_parent().queue_free()
	pass # Replace with function body.
