extends Area2D


@export var entity: Node2D
@export var moveable: Moveable

var target: Node2D


func _process(delta: float) -> void:
    if target != null:
        moveable.accel_direction(target.position-entity.position, delta)


func _on_body_entered(body:Node2D) -> void:
    target = body.entity

