extends Node


var camera: Camera2D


func slowdown(strength, length) -> void:
    Engine.time_scale = strength
    await get_tree().create_timer(length, false, false,true).timeout
    Engine.time_scale = 1.0


func blend(amount: float) -> float:
    return 1 - (0.5 ** (amount))