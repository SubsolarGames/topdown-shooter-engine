extends Node2D


@export var moveable: Moveable
@export var animated_character: AnimatedCharacter
@export var dust_particle: CPUParticles2D
@export var spawner: Spawner
@export var dash_particle: CPUParticles2D
@export var healthbox: HealthBox


func _physics_process(delta: float) -> void:
	var direction: Vector2 = Input.get_vector("left", "right", "up", "down")

	if direction != Vector2.ZERO:
		dust_particle.emitting = true
		moveable.accel_direction(direction, delta)
	else:
		dust_particle.emitting = false
		moveable.add_friction(delta)

	animated_character.animate()

	if Input.is_action_just_pressed("dash"):
		Globals.camera.screenshake(0.3, 3)

		$spawn_dash_ghost.start()
		moveable.dash()

	if Input.is_action_just_pressed("interact"):
		healthbox.damage(20)

	if moveable.state == moveable.STATES.dashing:
		dash_particle.rotation = animated_character.rotation - deg_to_rad(90)
		dash_particle.emitting = true

		if $spawn_dash_ghost.time_left == 0:
			$spawn_dash_ghost.start()
			spawner.spawn_obj(global_position, animated_character.rotation, animated_character.scale)
	else:
		dash_particle.emitting = false
