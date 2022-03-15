extends RigidBody2D

var held: bool = false
var mouse_on_object: bool = false

func _physics_process(delta):
	if held:
		global_transform.origin = get_global_mouse_position()

func _on_PickupObject_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed and mouse_on_object:
			if !held:
				mode = RigidBody2D.MODE_STATIC
				held = true
		else:
			if held:
				mode = RigidBody2D.MODE_RIGID
				held = false
			pass

func _on_PickupObject_mouse_entered() -> void:
	mouse_on_object = true

func _on_PickupObject_mouse_exited() -> void:
	mouse_on_object = false
