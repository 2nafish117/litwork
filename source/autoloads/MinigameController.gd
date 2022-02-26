extends CanvasLayer

signal minigame_end

var main_scene: Node = null
var minigame_scene: Node = null

func quit_minigame():
	minigame_scene.queue_free()
	emit_signal("minigame_end")
	pass

func start_minigame(minigame: PackedScene):
	minigame_scene = minigame.instance()
	add_child(minigame_scene)
