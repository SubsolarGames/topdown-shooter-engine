extends CPUParticles2D
class_name DashParticle


@export var moveable: Moveable


func activate() -> void:
    if moveable.state == moveable.STATES.dashing:
        emitting = true
    else:
        emitting = false