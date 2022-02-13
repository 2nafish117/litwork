extends Sprite

var floors: Array
var player: Node2D

func _ready() -> void:
	for c in get_children():
		if c is Floor:
			floors.append(c)

func interact(player: Node2D, data: Dictionary):
	var floor_number
	go_to_floor(player, floor_number)
	pass

func go_to_floor(player: Node2D, floor_number: int):
	for f in floors:
		if f.floor_number == floor_number:
			player.global_position = f.global_position
			return
	pass

func _on_Area2D_body_entered(body: Node) -> void:
	if player is PlayerCharecter:
		player = body
