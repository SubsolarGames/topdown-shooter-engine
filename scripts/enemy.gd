extends Node2D
class_name Enemy

@export var moveable: Moveable
@export var animated_character: AnimatedCharacter
@export var innac: float = 0.0
@export var speed_max: float = 0.0
@export var speed_min: float = 0.0
@export var gun: Gun

@onready var start_pos: Vector2 = position
@onready var innac_vector: Vector2 = Vector2(randf_range(-innac, innac), randf_range(-innac, innac))

enum STATES {
	run,
	shoot,
}

var target: Node2D
var state: STATES = STATES.run
var prev_delta: float = 0.0


func _ready() -> void:
	$nav_update.wait_time = randf_range(0.25, 1.5)
	$nav_update.start()
	moveable.speed = randf_range(speed_min, speed_max)


func _process(delta: float) -> void:
	if target:
		update_gun_target(delta)
		handle_shooting(delta)
	handle_movement(delta)
	animated_character.animate()


func update_gun_target(delta: float) -> void:
	if gun:
		gun.target = lerp(gun.target, Globals.player.position, 5 * delta)


func handle_shooting(delta: float) -> void:
	if state == STATES.shoot:
		update_shoot_ray()
		if can_shoot():
			moveable.add_friction(delta)
			gun.shoot()
		else:
			move_towards_next_path(delta)


func update_shoot_ray() -> void:
	$shoot_ray.position = $gun.offset
	$shoot_ray.target_position = Globals.player.position - position
	$shoot_ray.force_update_transform()


func can_shoot() -> bool:
	return not $shoot_ray.is_colliding()


func move_towards_next_path(delta: float) -> void:
	moveable.accel_direction(($NavigationAgent2D.get_next_path_position() - position).normalized(), delta)


func handle_movement(delta: float) -> void:
	if state == STATES.run:
		$NavigationAgent2D.set_velocity(($NavigationAgent2D.get_next_path_position() - position).normalized() * moveable.speed)
		prev_delta = delta

func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	moveable.accel_direction(safe_velocity, prev_delta)


func _on_nav_update_timeout() -> void:
	if target:
		$NavigationAgent2D.target_position = target.position + (innac_vector * ((target.position - position).length() / 100.0))
	else:
		$NavigationAgent2D.target_position = start_pos + Vector2(randf_range(-50, 50), randf_range(-50, 50))


func _on_shoot_range_body_entered(_body: Node2D) -> void:
	if gun:
		state = STATES.shoot


func _on_shoot_range_body_exited(_body: Node2D) -> void:
	state = STATES.run


func _on_dashrange_body_entered(_body: Node2D) -> void:
	moveable.dash()


func _on_interest_body_entered(body: Node2D) -> void:
	if target != Globals.player:
		target = body.entity
