extends KinematicBody2D

signal elevator_start
signal elevator_stop

export var elevator_duration: float = 3.0
export var single_exit: bool = false
export var floors_path: NodePath

onready var floor_collision: CollisionShape2D = $Floor
onready var roof_collision: CollisionShape2D = $Roof
onready var left_collision: CollisionShape2D = $Left
onready var right_collision: CollisionShape2D = $Right

onready var tween: Tween = $Tween
onready var door_animation_player: AnimationPlayer = $DoorAnimationPlayer
onready var floor_reached_audio: AudioStreamPlayer = $FloorReached
onready var button_pressed_audio: AudioStreamPlayer = $ButtonPressed

onready var elevator_button_container := $ElevatorControl/ElevatorControl/MarginContainer/VBoxContainer

onready var door_l_closed_pos: Vector2 = $door_l.position
onready var door_l_opened_pos: Vector2 = $door_l.position - Vector2(-150.0, 0.0)

onready var door_r_closed_pos: Vector2 = $door_r.position
onready var door_r_opened_pos: Vector2 = $door_r.position - Vector2(150.0, 0.0)

var elevator_button: PackedScene = preload("res://source/interactibles/elevator/ElevatorButton.tscn")

var floors: Array
var player: Node2D

var moving: bool = false
var door_closed: bool = true
var current_floor: Floor
var target_floor: Floor

func enable_collisions(enable: bool) -> void:
	if not single_exit:
		floor_collision.disabled = !enable
		roof_collision.disabled = !enable
		right_collision.disabled = !enable
		for f in floors:
			f.enable_collisions(!enable)
	left_collision.disabled = !enable

func _ready() -> void:
	enable_collisions(false)
	elevator_button_container.visible = false
	var floors_path_node = get_node(floors_path)
	
	# get all floor nodes and make buttons for them
	for c in floors_path_node.get_children():
		if c is Floor:
			floors.append(c)
			var btn := elevator_button.instance()
			elevator_button_container.add_child(btn)
			btn.set_floor_number(c.floor_number)
			btn.set_floor_name(c.floor_name)
			var _throw = btn.connect("pressed", self, "go_to_floor", [c.floor_number])
			current_floor = c

func restrict_to_floor(f: int):
	for b in elevator_button_container.get_children():
		b.disabled = b.get_floor_number() != f

func go_to_floor(floor_number: int):
	button_pressed_audio.play(0.0)
	for f in floors:
		if f.floor_number == floor_number:
			target_floor = f
	if current_floor == target_floor:
		return
	
	enable_collisions(true)
	if !door_closed:
		door_animation_player.play("elevator_doors_close")
		door_closed = true

func _on_Area2D_body_entered(body: Node) -> void:
	# show lift floor buttons
	
	if body is PlayerCharecter:
		print("player entered elevator")
		player = body
		elevator_button_container.visible = true
		if door_closed:
			door_animation_player.play("elevator_doors_open")
			door_closed = false

func _on_Area2D_body_exited(body: Node) -> void:
	# hide lift floor buttons
	if body is PlayerCharecter:
		print("player exited elevator")
		$door_l.z_index = 0
		$door_r.z_index = 0
		$ElevatorControl.z_index = 0
		player = null
		elevator_button_container.visible = false
		if !door_closed:
			door_animation_player.play("elevator_doors_close")
			door_closed = true

func _on_Tween_tween_completed(_object: Object, _key: NodePath) -> void:
	floor_reached_audio.play(0.0)
	current_floor = target_floor
	target_floor = null
	emit_signal("elevator_stop")
	if door_closed:
		door_animation_player.play("elevator_doors_open")
		door_closed = false
	pass

func _on_DoorAnimationPlayer_animation_finished(anim_name: String) -> void:
	if player != null and anim_name == "elevator_doors_open":
		$door_l.z_index = player.z_index + 1
		$door_r.z_index = player.z_index + 1
		$ElevatorControl.z_index = $door_r.z_index
		enable_collisions(false)
	elif player != null and anim_name == "elevator_doors_close":
		var _throw = tween.interpolate_property(self, "global_position", current_floor.global_position, target_floor.global_position, elevator_duration, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
		_throw = tween.start()
		emit_signal("elevator_start")
