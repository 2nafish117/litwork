class_name PlayerCharecter
extends KinematicBody2D

const MAX_SPEED = 200.0

var ACCEL := 60.0
var SPEED := MAX_SPEED

var movement: float
var input_interact: bool
var velocity: Vector2
var look: int = 1
var points := 0

enum {IDLE, INTERACT, WALK}
var state := IDLE

func _ready() -> void:
	# $AnimatedSprite.playing = true
	pass

func _physics_process(delta: float) -> void:
	movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_interact = Input.is_action_just_pressed("action_interact")
	
	# gravity
	if not is_on_floor():
		velocity.y += 200.0 * delta
	velocity.x = lerp(velocity.x, movement * SPEED, ACCEL * delta)

#	match state:
#		IDLE:
#			if abs(velocity.x) > 0.01:
#				state = WALK
#				if velocity.x > 0.01:
#					$AnimatedSprite.animation = "walk_right"
#				if velocity.x < -0.01:
#					$AnimatedSprite.animation = "walk_left"
#			pass
#		INTERACT:
#			if abs(velocity.x) > 0.01:
#				state = WALK
#				if velocity.x > 0.01:
#					$AnimatedSprite.animation = "walk_right"
#				if velocity.x < -0.01:
#					$AnimatedSprite.animation = "walk_left"
#			pass
#		WALK:
#			if abs(velocity.x) <= 0.01:
#				state = IDLE
#				$AnimatedSprite.animation = "idle"
#			else:
#				if velocity.x > 0.01:
#					$AnimatedSprite.animation = "walk_right"
#				if velocity.x < -0.01:
#					$AnimatedSprite.animation = "walk_left"
#			pass
	
#	if false:
#		if movement > 0.0:
#			$AnimatedSprite.animation = "walk_right"
#			look = 1
#		elif movement < 0.0:
#			$AnimatedSprite.animation = "walk_left"
#			look = -1
#		else:
#			if look == -1:
#				$AnimatedSprite.animation = "idle_left"
#			else:
#				$AnimatedSprite.animation = "idle_right"
		
	velocity = move_and_slide(velocity, Vector2.UP)
	pass

func interact(can_move: bool) -> void:
	print("player interact")
	state = INTERACT
	if not can_move:
#		$AnimatedSprite.animation = "interact"
		SPEED = 0.0
		velocity.x = 0.0
	pass

#func _on_DialogBox_interaction_end() -> void:
#	state = IDLE
#	$AnimatedSprite.animation = "idle"
#	SPEED = MAX_SPEED
