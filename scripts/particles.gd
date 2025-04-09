extends CPUParticles2D


@export var effect_scale: float = 1.0


func _ready() -> void:
    initial_velocity_min *= effect_scale
    initial_velocity_max *= effect_scale
    damping_min *= effect_scale
    damping_max *= effect_scale
    scale_amount_min *= effect_scale
    scale_amount_max *= effect_scale

    $ring_effect.scale *= effect_scale

    emitting = true


func _on_finished() -> void:
    queue_free()
