class_name PlayerVehicle
extends RigidBody2D

export var player_in_control: bool = true

const MAX_ANGULAR_ACCEL = 3.0
const MAX_ANGULAR_VELOCITY = 30.0
const MIN_ANGULAR_VELOCITY = 5.0

var wheel_angular_velocity: float = 15.0
var input: float

var movement_modifier: float = 1.0

func _physics_process(delta: float) -> void:
	if player_in_control:
		input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	input *= movement_modifier
	
	if input != 0.0:
		wheel_angular_velocity = clamp(wheel_angular_velocity + delta * MAX_ANGULAR_ACCEL, MIN_ANGULAR_VELOCITY, MAX_ANGULAR_VELOCITY)
	else:
		wheel_angular_velocity = MIN_ANGULAR_VELOCITY
	$BackWheel.angular_velocity = input * wheel_angular_velocity
	$FrontWheel.angular_velocity = input * wheel_angular_velocity

