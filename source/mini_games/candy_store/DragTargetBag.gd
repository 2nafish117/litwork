extends Panel

signal candy_dropped(point)

export var bag_color: String

onready var texture_rect = $TextureRect

func can_drop_data(position: Vector2, data) -> bool:
	var can_drop: bool = data is Node and data .is_in_group("draggable")
	if can_drop or (position.x < texture_rect.rect_size.x and position.y < texture_rect.rect_size.y):
		texture_rect.rect_scale = Vector2(1.2, 1.2)
	else:
		texture_rect.rect_scale = Vector2(1.0, 1.0)
	return can_drop

func drop_data(position: Vector2, data) -> void:
	texture_rect.rect_scale = Vector2(1.0, 1.0)
	print("candy: ", data.candy_color, " bag: ", bag_color)
	if data.candy_color == bag_color:
		emit_signal("candy_dropped", 1)
		$Correct.play(0.0)
	else:
		emit_signal("candy_dropped", -1)
		$Wrong.play(0.0)

func _on_DragTargetBag_mouse_exited() -> void:
	texture_rect.rect_scale = Vector2(1.0, 1.0)
