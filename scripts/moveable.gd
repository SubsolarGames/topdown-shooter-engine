extends CharacterBody2D
class_name Moveable


signal collided

@export var entity: Node
@export var speed: float = 0.0
@export var accel: float = 0.0
@export var friction: float = 0.0
@export var dash_speed: float = 0.0
@export var collide_signal: bool = false
@export var always_friction: bool = false
@export var slowdown: float = 0.0
@export var bounce: bool = false
@export var random_force: bool = false
@export var dash_sound: SoundEffect.SOUND_EFFECT_TYPE

enum STATES {
    moving,
    still,
    dashing
}

var state: STATES = STATES.still
var last_dir: Vector2 = Vector2.ZERO


func _ready() -> void:
    if random_force:
        add_force(Vector2(randf_range(speed * 0.7, speed * 1.3), 0).rotated(deg_to_rad(randf_range(0, 360))))


func _physics_process(delta: float) -> void:
    if not collide_signal:
        move_and_slide()
    else:
        var collision_info = move_and_collide(velocity * delta)

        if collision_info:
            if bounce:
                velocity = velocity.bounce(collision_info.get_normal())
                
            collided.emit()

    if always_friction:
        add_friction(delta)

    entity.position = global_position
    position = Vector2.ZERO


func accel_direction(direction: Vector2, delta: float):
    if state != STATES.dashing:
        state = STATES.moving
    last_dir = direction
    velocity = lerp(velocity, direction.normalized() * (speed-slowdown), Globals.blend(accel * delta))


func add_force(force: Vector2):
    velocity += force


func add_friction(delta: float) -> void:
    velocity = lerp(velocity, Vector2.ZERO, Globals.blend(friction * delta))
    
    if state != STATES.dashing:
        state = STATES.still


func dash() -> void:
    AudioManager.play_sound(dash_sound, entity.position)

    state = STATES.dashing

    get_tree().create_timer(0.0006 * dash_speed).timeout.connect(func():
        state = STATES.still)

    velocity = last_dir.normalized() * dash_speed