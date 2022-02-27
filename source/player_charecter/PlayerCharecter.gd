class_name PlayerCharecter
extends KinematicBody2D

signal speech_spoken

const MAX_SPEED = 250.0
const ACCEL := 50.0
const EPSILON_VELOCITY := 0.1

export var male: bool = true

var speed := MAX_SPEED

var movement_modifier: float = 1.0

var movement: float
var input_interact: bool
var velocity: Vector2
var look: int = 1
var points := 0

enum {IDLE, INTERACT, WALK}
var state := IDLE

export var can_input_on_ready: bool = true

onready var animated_sprite: AnimatedSprite = $AnimatedSpriteMale

func _ready() -> void:
	$AnimatedSpriteFemale.visible = false
	$AnimatedSpriteMale.visible = false
	
	# testing
	#GlobalDetails.player_info["sex"] = "female"
	
	if GlobalDetails.player_info["sex"] == "female":
		animated_sprite = $AnimatedSpriteFemale
	
	animated_sprite.visible = true
	animated_sprite.playing = true


func _physics_process(delta: float) -> void:
	if can_input_on_ready:
		movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		movement *= movement_modifier
	else:
		movement = 0.0
		
	input_interact = Input.is_action_just_pressed("action_interact")
	
	if !is_on_floor():
		velocity.y += 300.0 * delta
	velocity.x = lerp(velocity.x, movement * speed, ACCEL * delta)

	match state:
		IDLE:
			if abs(velocity.x) > EPSILON_VELOCITY:
				state = WALK
			pass
		INTERACT:
			if abs(velocity.x) > EPSILON_VELOCITY:
				state = WALK
			pass
		WALK:
			if abs(velocity.x) <= EPSILON_VELOCITY:
				state = IDLE
				animated_sprite.animation = "idle"
			else:
				animated_sprite.animation = "walk"
				if velocity.x > EPSILON_VELOCITY:
					animated_sprite.flip_h = false
				if velocity.x < -EPSILON_VELOCITY:
					animated_sprite.flip_h = true
			pass

	var snap: Vector2 = -get_floor_normal() * 100.0
	velocity = move_and_slide_with_snap(velocity, snap, Vector2.UP, true, 4, PI/4.0, true)
	pass

func interact(can_move: bool) -> void:
	print("player interact")
	state = INTERACT
	if not can_move:
		speed = 0.0
		velocity.x = 0.0
	pass


func _on_InputTimer_timeout() -> void:
	can_input_on_ready = true
