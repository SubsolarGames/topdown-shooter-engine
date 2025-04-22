extends Node2D


@export var fade_time: float
@export var delete: bool = false


func _ready() -> void:
    var tween = get_tree().create_tween()
    
    tween.tween_property(self, "modulate", Color(0, 0, 0, 0), fade_time)
    
    if delete:
        tween.tween_callback(queue_free)