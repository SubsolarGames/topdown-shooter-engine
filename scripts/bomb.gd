extends Node2D


@export var explosion_scene: PackedScene
@export var explosion_scale: float = 1.0
@export var healthbox: HealthBox


func _ready() -> void:
    healthbox.died.connect(func():
        var inst: Node2D = explosion_scene.instantiate()
        inst.position = position
        inst.effect_scale = explosion_scale
        get_parent().add_child(inst)
    )
