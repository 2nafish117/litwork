class_name Floor
extends StaticBody2D

export var floor_number: int
export var floor_name: String

func enable_collisions(enable: bool) -> void:
	for c in get_children():
		if c is CollisionShape2D:
			c.disabled = !enable
