extends CPUParticles2D


@export var effect_scale: float = 1.0
@export var on_start: bool = true


func _ready() -> void:
	if on_start:
		setoff()


func setoff():
	initial_velocity_min *= effect_scale
	initial_velocity_max *= effect_scale
	damping_min *= effect_scale
	damping_max *= effect_scale
	scale_amount_min *= effect_scale
	scale_amount_max *= effect_scale

	if len(get_children()) != 0:
		$ring_effect.scale *= effect_scale

	emitting = true


func _on_finished() -> void:
	queue_free()
