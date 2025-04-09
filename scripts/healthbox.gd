extends Area2D
class_name HealthBox


@export var entity: Node2D
@export var sprite: Sprite2D
@export var health: float = 0.0
@export var screenshake_hit: float = 0.0
@export var screenshake_duration: float = 0.0
@export var frame_freeze_duration: float = 0.0
@export var die_effect_mul: float = 0.0
@export var particles_color: Color = Color(1, 1, 1, 1)
@export var particle_scale: float = 0.0
@export var particle_scene: PackedScene


func damage(amount: float) -> void:
	health -= amount

	sprite.material.set_shader_parameter("active", true)
	get_tree().create_timer(0.15).timeout.connect(func():
		sprite.material.set_shader_parameter("active", false))

	if health > 0:
		Globals.camera.screenshake(screenshake_duration, screenshake_hit)
		Globals.slowdown(0, frame_freeze_duration)
	else:
		Globals.camera.screenshake(screenshake_duration * die_effect_mul, screenshake_hit * die_effect_mul)
		Globals.slowdown(0, frame_freeze_duration * die_effect_mul)

		var inst: CPUParticles2D = particle_scene.instantiate()
		inst.modulate = particles_color
		inst.effect_scale = particle_scale
		inst.position = entity.position
		entity.get_parent().add_child(inst)

		entity.queue_free()
