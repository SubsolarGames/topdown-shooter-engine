extends Area2D
class_name HealthBox

signal died
signal take_damage

@export var entity: Node2D
@export var moveable: Moveable
@export var sprite: Sprite2D
@export var knockback_mul: float = 1.0
@export var max_health: float = 0.0
@export var health: float = 0.0
@export var screenshake_hit: float = 0.0
@export var screenshake_duration: float = 0.0
@export var frame_freeze_duration: float = 0.0
@export var die_effect_mul: float = 0.0
@export var particles_color: Color = Color(1, 1, 1, 1)
@export var particle_scale: float = 0.0
@export var particle_scene: PackedScene
@export var hit_particle_scale: float = 0.0
@export var hit_particle_scene: PackedScene
@export var destroy_when_die: bool = true
@export var die_sound: SoundEffect.SOUND_EFFECT_TYPE
@export var hit_sound: SoundEffect.SOUND_EFFECT_TYPE

var invinc: bool = false
var hit_dir: float = 0.0
var dead: bool = false


func damage(amount: float, knockback: float) -> void:
	if not dead:
		health -= amount

		if sprite != null:
			sprite.material.set_shader_parameter("active", true)
			get_tree().create_timer(0.15).timeout.connect(func():
				sprite.material.set_shader_parameter("active", false))

		moveable.add_force(Vector2(knockback, 0).rotated(hit_dir) * knockback_mul)

		if health > 0:
			AudioManager.play_sound(hit_sound, entity.position)
			Globals.camera.screenshake(screenshake_duration, screenshake_hit)
			Globals.slowdown(0, frame_freeze_duration)

			var inst: CPUParticles2D = hit_particle_scene.instantiate()
			inst.modulate = particles_color
			inst.effect_scale = hit_particle_scale
			inst.rotation = hit_dir
			inst.position = entity.position
			entity.get_parent().add_child(inst)

			take_damage.emit()
		else:
			AudioManager.play_sound(die_sound, entity.position)
			Globals.camera.screenshake(screenshake_duration * die_effect_mul, screenshake_hit * die_effect_mul)
			Globals.slowdown(0, frame_freeze_duration * die_effect_mul)

			var inst: CPUParticles2D = particle_scene.instantiate()
			inst.modulate = particles_color
			inst.effect_scale = particle_scale
			inst.position = entity.position
			entity.get_parent().add_child(inst)

			died.emit()
			dead = true

			if destroy_when_die:
				entity.queue_free()


func _on_area_entered(area:Area2D) -> void:
	if area is DamageBox and not invinc:
		area.damaged.emit()

		if len(area.get_parent().get_children().filter(func(obj): return obj is Moveable)) > 0:
			var moveable_obj: Moveable = area.get_parent().get_children().filter(func(obj): return obj is Moveable)[0]

			if moveable_obj.velocity != Vector2.ZERO:
				hit_dir = moveable_obj.velocity.angle()
			else:
				hit_dir = moveable.velocity.angle() + deg_to_rad(180)

		damage(area.damage, area.knockback)
