extends CharacterBody2D
class_name Moveable

signal collided

@export var entity: Node
@export var speed: float = 0.0
@export var accel: float = 0.0
@export var friction: float = 0.0
@export var dash_speed: float = 0.0
@export var collide_signal: bool = false


enum STATES {
    moving,
    still,
    dashing
}

var state: STATES = STATES.still

func _physics_process(delta: float) -> void:
    if not collide_signal:
        move_and_slide()
    else:
        var collision_info = move_and_collide(velocity * delta)

        if collision_info:
            collided.emit()

    entity.position = global_position
    position = Vector2.ZERO


func accel_direction(direction: Vector2, delta: float):
    if state != STATES.dashing:
        state = STATES.moving
    velocity = lerp(velocity, direction.normalized() * speed, Globals.blend(accel * delta))



func add_force(force: Vector2):
    velocity += force


func add_friction(delta: float) -> void:
    velocity = lerp(velocity, Vector2.ZERO, Globals.blend(friction * delta))
    
    if state != STATES.dashing:
        state = STATES.still


func dash() -> void:
    state = STATES.dashing

    get_tree().create_timer(0.0006 * dash_speed).timeout.connect(func():
        state = STATES.still)

    velocity = velocity.normalized() * dash_speed