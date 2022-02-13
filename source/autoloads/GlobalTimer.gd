extends Timer

func _ready() -> void:
	wait_time = 30 * 60
	one_shot = true
	autostart = false
	pass

func _on_GlobalTimer_timeout() -> void:
	# what happens on timeout??? player booted??
	pass # Replace with function body.
