tool
extends Node2D

export var frequency: float = 3.0
export var amplitude: float = 0.1

export var clipped: bool = false

var time = 0.0

func _process(delta: float) -> void:
	time += delta
	var value = amplitude * sin(frequency * time)
	value = abs(value) if clipped else value
	position.y += value
