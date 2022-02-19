extends Camera2D


export var center_offset: Vector2 = Vector2(0, -100)
export var smoothing: float = 10.0
export var player_path: NodePath setget set_player_path

func set_player_path(val: NodePath):
	player_path = val
	if !val.is_empty():
		player = get_node_or_null(val)

var player: Node2D

func _ready() -> void:
	if !player_path.is_empty():
		player = get_node_or_null(player_path)
		global_position = player.global_position + center_offset
	pass

onready var _offset: Vector2 = center_offset

func _physics_process(delta: float) -> void:
	if player != null:
		var input: float = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		if input != 0.0:
			_offset = center_offset + Vector2.RIGHT * input * 100.0
		global_position = lerp(global_position,player.global_position + _offset, smoothing * delta)
	pass
