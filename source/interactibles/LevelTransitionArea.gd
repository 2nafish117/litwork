extends Area2D

export var scene: PackedScene
export var active: bool = false
export var begin_on_enter: bool = true
export var first_objective: bool = false
export(String, MULTILINE) var objective_text: String = ""

var player: Node2D = null

func _ready() -> void:
	if first_objective:
		ObjectiveController.set_current_objective(self)

func _process(delta: float) -> void:
	if !active:
		return
	
	if player != null and scene != null:
		if begin_on_enter:
			var _throw = get_tree().change_scene_to(scene)
		else:
			if Input.is_action_just_pressed("action_interact"):
				var _throw = get_tree().change_scene_to(scene)
	

func _on_LevelTransitionArea_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player = body

func _on_LevelTransitionArea_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		player = null
