extends Area2D

export var prompt_show_duration: float = 5.0
export var active: bool = false

var player: Node2D

var sprites: Array

func _ready() -> void:
	$Timer.wait_time = prompt_show_duration
	for c in get_children():
		if c is Sprite:
			sprites.append(c)
			c.visible = false

func _on_ButtonPromptsArea_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		print("player in prompt area")
		$AudioStreamPlayer.play(0.0)
		$Timer.start()
		active = false
		player = body
		for c in sprites:
			c.visible = true


func _on_Timer_timeout() -> void:
	for c in sprites:
		c.visible = false
		
func _process(_delta: float) -> void:
	for c in sprites:
		c.global_position.y += 0.03 * sin(5.0 * $Timer.time_left)
	pass
