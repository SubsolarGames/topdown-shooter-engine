extends Node2D
class_name Interactable


@export var healthbox: HealthBox
@export var move_at_start: bool = true

var rotation_velocity: float = 0.0
var active: bool = false


func _ready() -> void:
    if move_at_start:
        $Sprite2D.rotation_degrees = randf_range(0, 360)
        rotation_velocity = randf_range(100, 200)


func _process(delta: float) -> void:
    $Sprite2D.rotation_degrees += rotation_velocity * delta
    rotation_velocity = move_toward(rotation_velocity, 0, 50 * delta)

    $Sprite2D.material.set_shader_parameter("width", 1 * int(active))
    $text.visible = active

    if active and Input.is_action_just_pressed("interact"):
        give_item()
        healthbox.damage(0, 0)


func give_item() -> void:
    pass


func _on_area_2d_body_entered(_body:Node2D) -> void:
    active = true


func _on_area_2d_body_exited(_body:Node2D) -> void:
    active = false