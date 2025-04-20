extends Sprite2D


@export var sin_height: float = 0.0
@export var sin_speed: float = 0.0

@onready var sin_ticker: float = randf_range(0, 100)


func _process(delta: float) -> void:
    offset.y = sin(sin_ticker) * sin_height
    sin_ticker += sin_speed * delta