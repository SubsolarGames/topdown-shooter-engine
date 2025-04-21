extends Camera2D


@export var target: Node2D
@export var lerp_speed: float = 10.0
@export var cursor_weight: float = 0.2

var shake_ticker: float = 0.0
var shake_size: float = 0.0

var target_pos: Vector2 = Vector2.ZERO


func _ready() -> void:
    Globals.camera = self


func screenshake(duration, size) -> void:
    shake_ticker += max(duration - shake_ticker, 0)
    shake_size = size


func _physics_process(delta: float) -> void:
    offset = Vector2(randf_range(-shake_size, shake_size), randf_range(-shake_size, shake_size))

    if shake_ticker > 0:
        shake_ticker -= delta
    else:
        shake_size = 0.0


    if target != null:
        target_pos = (cursor_weight * get_global_mouse_position()) + ((1.0-cursor_weight) * target.position)
    else:
        target_pos = (cursor_weight * get_global_mouse_position()) + ((1.0-cursor_weight) * Vector2.ZERO)


    position = lerp(position, target_pos, lerp_speed * delta)

