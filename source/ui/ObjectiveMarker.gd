extends Node2D

export(NodePath) var camera_path: NodePath
#export(NodePath) var objective_path: NodePath

export var margin_horizontal := 100.0
export var margin_vertical := 100.0

onready var camera: Camera2D = get_node(camera_path)
onready var objective: Node2D = null

onready var limits: Rect2 = get_viewport_rect()

var time := 0.0

func _ready() -> void:
	ObjectiveController.set_marker(self)

func _physics_process(delta: float) -> void:
	time += delta
	if objective == null or camera == null:
		return
		
	var size: Vector2 = limits.size * 0.5
	var center := camera.get_camera_screen_center()
	var pos: Vector2 = objective.global_position
	
	if global_position.distance_to(objective.global_position) <= 200:
		#global_position = objective.global_position + Vector2.UP * 50.0
		pos = objective.global_position - Vector2(0.0, 1.0) * 150.0
		pos.y += 4.0 * sin(time * 5.0)
	
	pos.x = clamp(pos.x, center.x - size.x + margin_horizontal, center.x + size.x - margin_horizontal)
	pos.y = clamp(pos.y, center.y - size.y + margin_vertical, center.y + size.y - margin_vertical)
	global_position = global_position.linear_interpolate(pos, delta * 10)
	look_at(objective.global_position)
	
