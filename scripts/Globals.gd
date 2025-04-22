extends Node


var camera: Camera2D
var player: Player
var ui: CanvasLayer
var world: Node2D

var hit_effect_value: float = 0.0
var hit_perm_value: float = 0.0

var coins: int = 0
var coin_effect_pos: Vector2 = Vector2.ZERO

var screenshake_mul: float = 1.0
var sfx_volume: float = 0.0
var music_volume: float = 0.0


func slowdown(strength, length) -> void:
    Engine.time_scale = strength
    await get_tree().create_timer(length, false, false,true).timeout
    Engine.time_scale = 1.0


func hit_effect(length: float) -> void:
    hit_effect_value = 1.0
    get_tree().create_timer(length).timeout.connect(func():
        hit_effect_value = 0.0
    )


func blend(amount: float) -> float:
    return 1 - (0.5 ** (amount))


func reset():
    coins = 0