extends Node2D


@export var moveable: Moveable
@export var animated_character: AnimatedCharacter
@export var dust_particle: CPUParticles2D
@export var spawner: Spawner
@export var dash_particle: CPUParticles2D
@export var healthbox: HealthBox
@export var gun: Gun



func _ready() -> void:
	Globals.player = self


func _process(delta: float) -> void:
	gun.target = get_global_mouse_position()
	
	var direction: Vector2 = Input.get_vector("left", "right", "up", "down")

	if direction != Vector2.ZERO:
		dust_particle.emitting = true
		moveable.accel_direction(direction, delta)
	else:
		dust_particle.emitting = false
		moveable.add_friction(delta)

	animated_character.animate()

	if Input.is_action_just_pressed("dash"):
		Globals.camera.screenshake(0.3, 1)

		$spawn_dash_ghost.start()
		moveable.dash()


	if Input.is_action_pressed("shoot"):
		gun.shoot()
		moveable.slowdown = gun.slowdown
	else:
		moveable.slowdown = 0

	healthbox.get_children()[0].disabled = moveable.state == moveable.STATES.dashing
	
	if moveable.state == moveable.STATES.dashing:
		dash_particle.rotation = animated_character.rotation - deg_to_rad(90)
		dash_particle.emitting = true

		if $spawn_dash_ghost.time_left == 0:
			$spawn_dash_ghost.start()
			spawner.spawn_obj(global_position, animated_character.rotation, animated_character.scale)
	else:
		dash_particle.rotation = moveable.velocity.angle()
		dash_particle.emitting = false
