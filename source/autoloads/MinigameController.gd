extends CanvasLayer

signal minigame_end

var main_scene: Node = null
var minigame_scene: Node = null

func quit_minigame():
	print("queue_free minigame")
	minigame_scene.queue_free()
	GlobalTimer.paused = false
	emit_signal("minigame_end")
	pass

func start_minigame(minigame: PackedScene):
	print("strat timigame")
	GlobalTimer.paused = true
	minigame_scene = minigame.instance()
	add_child(minigame_scene)
