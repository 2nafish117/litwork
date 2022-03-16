extends Control

var Candy := preload("res://source/mini_games/candy_store/DraggableCandy.tscn")

onready var candy_container := $MarginContainer/HSeparator/HBoxContainer/MarginContainer/CandyContainer
onready var candy := candy_container.get_node(@"DraggableCandy")

onready var timer_label := $MarginContainer/HSeparator/TimeLabel
onready var timer := $Timer

var colors = ["blue", "yellow", "green", "purple"]

var player_score: int = 0

func _ready() -> void:
	var random := randi() % 4
	candy.set_candy_color(colors[random])

func handle_point(point: int):
	candy.visible = true
	player_score += point
	var random := randi() % 4
	candy.set_candy_color(colors[random])

func _on_Blue_candy_dropped(point: int) -> void:
	handle_point(point)

func _on_Purple_candy_dropped(point: int) -> void:
	handle_point(point)

func _on_Green_candy_dropped(point: int) -> void:
	handle_point(point)

func _on_Yellow_candy_dropped(point: int) -> void:
	handle_point(point)

func format_time(secs: float) -> Array:
	var minutes = int(secs / 60.0)
	secs = int(fmod(secs, 60.0))
	return [minutes, secs]

func _process(delta: float) -> void:
	var t: Array = format_time(timer.time_left)
	var minutes: int = t[0]
	var seconds: int = t[1]
	var time_string: String
	if seconds < 30:
		timer_label.self_modulate = Color.red
		
	time_string = String(minutes).pad_zeros(2) + ":" + String(seconds).pad_zeros(2)
	timer_label.text = time_string

func _on_Timer_timeout() -> void:
	GlobalDetails.player_choices["candy_store"] = {
		"score": player_score
	}
	print(GlobalDetails.player_choices)
	MinigameController.quit_minigame()

func _on_CandyContainer_candy_dropped() -> void:
	candy.visible = true
