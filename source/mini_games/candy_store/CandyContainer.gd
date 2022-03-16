extends CenterContainer

signal candy_dropped

func can_drop_data(position: Vector2, data) -> bool:
	var can_drop: bool = data is Node and data .is_in_group("draggable")
	return can_drop

func drop_data(position: Vector2, data) -> void:
	emit_signal("candy_dropped")
	$AudioStreamPlayer.play(0.0)
