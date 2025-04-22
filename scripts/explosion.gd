extends Node2D


@export var effect_scale: float = 1.0


func _ready() -> void:
    AudioManager.play_sound(SoundEffect.SOUND_EFFECT_TYPE.EXPLOSION, position)
    
    $CPUParticles2D.effect_scale = effect_scale
    $CPUParticles2D.setoff()

    $CPUParticles2D2.effect_scale = effect_scale
    $CPUParticles2D2.setoff()

    $CPUParticles2D3.effect_scale = effect_scale
    $CPUParticles2D3.setoff()

    Globals.camera.screenshake(0.5, 10 * effect_scale)
    scale = Vector2(effect_scale, effect_scale)
    Globals.slowdown(0.0, 0.05 * effect_scale)