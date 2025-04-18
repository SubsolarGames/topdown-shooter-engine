extends Node2D
class_name Enemy


@export var moveable: Moveable
@export var animated_character: AnimatedCharacter
@export var innac: float = 0.0
@export var speed_max: float = 0.0
@export var speed_min: float = 0.0
@export var gun: Gun

@onready var innac_vector: Vector2 = Vector2(randf_range(-innac, innac), randf_range(-innac, innac))

enum STATES {
	run,
	shoot,
}

var state: STATES = STATES.run


func _ready() -> void:
	$nav_update.wait_time = randf_range(0.25, 1.5)
	$nav_update.start()
	moveable.speed = randf_range(speed_min, speed_max)


func _process(delta: float) -> void:
	if gun:
		gun.target = lerp(gun.target, Globals.player.position, 5 * delta)

	if state == STATES.run:
		moveable.accel_direction(($NavigationAgent2D.get_next_path_position() - position).normalized(), delta)

	if state == STATES.shoot:
		$shoot_ray.position = $gun.offset
		$shoot_ray.target_position = Globals.player.position-position
		$shoot_ray.force_update_transform()

		if not $shoot_ray.is_colliding():
			moveable.add_friction(delta)

			gun.shoot()
		else:
			moveable.accel_direction(($NavigationAgent2D.get_next_path_position() - position).normalized(), delta)


		
	animated_character.animate()


func _on_nav_update_timeout() -> void:
	$NavigationAgent2D.target_position = Globals.player.position + (innac_vector*((Globals.player.position-position).length()/100.0))


func _on_shoot_range_body_entered(body: Node2D) -> void:
	if gun:
		state = STATES.shoot


func _on_shoot_range_body_exited(body: Node2D) -> void:
	state = STATES.run


func _on_dashrange_body_entered(body: Node2D) -> void:
	moveable.dash()
