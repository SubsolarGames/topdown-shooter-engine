extends Node2D
class_name Collectable


@export var healthbox: HealthBox


func _ready() -> void:
	$moveable.add_force(Vector2(randf_range(10, 25), 0).rotated(deg_to_rad(randf_range(0, 360))))
	healthbox.died.connect(give_item)


func give_item() -> void:
	pass
