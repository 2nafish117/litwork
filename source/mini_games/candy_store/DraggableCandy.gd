extends Panel

onready var texture_rect := $TextureRect

var candy_color: String

var candy_types: Dictionary = {
	"blue": preload("res://source/mini_games/candy_store/assets/blue_candy1.png"),
	"yellow": preload("res://source/mini_games/candy_store/assets/yellow_candy1.png"),
	"green": preload("res://source/mini_games/candy_store/assets/red_candy.png"),
	"purple": preload("res://source/mini_games/candy_store/assets/purple_candy2.png")
}

func _ready() -> void:
	add_to_group("draggable")

func get_drag_data(_position: Vector2):
	set_drag_preview(_get_preview_control())
	visible = false
	print(visible)
	return self

func _get_preview_control() -> Control:
	var drag_preview = TextureRect.new()
	drag_preview.rect_size = 1.5 * Vector2(texture_rect.texture.get_width(), texture_rect.texture.get_height())
	drag_preview.expand = true
	drag_preview.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	drag_preview.texture = texture_rect.texture
	var center_on_mouse_control = Control.new()
	center_on_mouse_control.add_child(drag_preview)
	drag_preview.rect_position = -0.5 * drag_preview.rect_size

	return center_on_mouse_control

func set_candy_color(color: String):
	if not color in ["blue", "yellow", "green", "purple"]:
		printerr("candy color cannot be ", color, " defaulting to blue")
		color = "blue"
	texture_rect.texture = candy_types[color]
	candy_color = color
