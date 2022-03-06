extends Node2D

var result=[]
var n=0
var path ="res://MINI GAMES/Professor Hoax/files/Hoax.json"
onready var qlabel = get_node("question")
onready var option1 = get_node("option1")
onready var option2 = get_node("option2")
onready var option3 = get_node("option3")
onready var option4 = get_node("option4")

onready var timer = get_node("Time")
onready var scorer = get_node("Score")
var timer_on = false
var time=0
var secs =0
var mins =4
var qno =1
var score =0
func _process(delta):
	if (timer_on):
		time+=delta
		scorer.score(score)
		secs = fmod(time,60)
		mins =(4*60- time)/60
		var time_passed = " %02d : %02d" % [mins,60-secs]
		timer.time(time_passed)
		if n<6:
			question(n)
		else :
			qlabel.label_update("Well Done!!")
			option1.visible=false
			option2.visible=false
			option3.visible=false
			option4.visible=false
			timer_on = false
			yield(get_tree().create_timer(1.0), "timeout")
			end()
			
		
		if secs>240:
			end()
		pass

func question(n):
	var file = File.new()
	file.open(path, file.READ)
	var text = file.get_as_text()
	var result_json = JSON.parse(text)
	if result_json.error != OK:
		print("[load_json_file] Error loading JSON file '" + str(path) + "'.")
		print("\tError: ", result_json.error)
		print("\tError Line: ", result_json.error_line)
		print("\tError String: ", result_json.error_string)
		return null
	result= result_json.result
	
	
	qlabel.label_update(result[n].question)
	option1.option1_text(result[n].option1)
	option2.option2_text(result[n].option2)
	option3.option3_text(result[n].option3)
	option4.option4_text(result[n].option4)
	


func _on_option1_pressed():
	
	print("option 1 selected")
	if result[n].answer== option1.text:
		print("correct option1")
		score+=1
	else:
		score-=1
	n+=1
	pass # Replace with function body.


func _on_option2_pressed():
	
	print("option 2 selected")
	if result[n].answer == option2.text:
		print("correct option2")
		score+=1
	else:
		score-=1
	n+=1	
	pass # Replace with function body.


func _on_option3_pressed():
	
	print("option 3 selected")
	
	if result[n].answer==option3.text:
		print("correct option3")
		score+=1
	else:
		score-=1
		
	n+=1
	pass # Replace with function body.

func _on_option4_pressed():
	print("option 2 selected")
	if result[n].answer == option2.text:
		print("correct option2")
		score+=1
	else:
		score-=1
	n+=1
	pass # Replace with function body.

func end():
			get_tree().change_scene("res://MINI GAMES/Professor Hoax/HoaxEndScene.tscn")
			queue_free()


func _on_Start_pressed():
	timer_on = true
	pass # Replace with function body.



