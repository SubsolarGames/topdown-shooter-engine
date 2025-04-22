extends Node2D


@export var scale_min: float = 0.05
@export var scale_max: float = 0.15


func _ready() -> void:
    rotation_degrees = randf_range(0, 360)
    scale = Vector2(randf_range(scale_min, scale_max),randf_range(scale_min, scale_max))
