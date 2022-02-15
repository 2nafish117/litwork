class_name PlayerCharecter
extends KinematicBody2D

const MAX_SPEED = 200.0
const ACCEL := 50.0
const EPSILON_VELOCITY := 0.1

export var male: bool = true

var speed := MAX_SPEED

var movement: float
var input_interact: bool
var velocity: Vector2
var look: int = 1
var points := 0

enum {IDLE, INTERACT, WALK}
var state := IDLE

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
	movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_interact = Input.is_action_just_pressed("action_interact")
	
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

	velocity = move_and_slide(velocity, Vector2.UP)
	pass

func interact(can_move: bool) -> void:
	print("player interact")
	state = INTERACT
	if not can_move:
		speed = 0.0
		velocity.x = 0.0
	pass

#func _on_DialogBox_interaction_end() -> void:
#	state = IDLE
#	animated_sprite.animation = "idle"
#	SPEED = MAX_SPEED
