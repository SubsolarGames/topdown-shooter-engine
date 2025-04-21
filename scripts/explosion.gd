extends Node2D


@export var effect_scale: float = 1.0


func _ready() -> void:
    $CPUParticles2D.effect_scale = effect_scale
    $CPUParticles2D.setoff()

    $CPUParticles2D2.effect_scale = effect_scale
    $CPUParticles2D2.setoff()

    Globals.camera.screenshake(1, 10 * effect_scale)
    scale = Vector2(effect_scale, effect_scale)
    Globals.slowdown(0.0, 0.05 * effect_scale)