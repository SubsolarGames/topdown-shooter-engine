extends Sprite2D


@export var rot_speed: float = 150.0


func _process(delta: float) -> void:
    position = get_global_mouse_position()
    rotation_degrees += rot_speed * delta