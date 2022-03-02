extends TextureButton

func get_floor_number():
	return int($FloorNumberLabel.text)
	
func get_floor_name():
	return $FloorNameLabel.text

func set_floor_number(number: int):
	$FloorNumberLabel.text = String(number)
	
func set_floor_name(name: String):
	$FloorNameLabel.text = name
