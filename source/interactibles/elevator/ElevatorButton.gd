extends TextureButton

func set_floor_number(number: int):
	$FloorNumberLabel.text = String(number)
	
func set_floor_name(name: String):
	$FloorNameLabel.text = name
