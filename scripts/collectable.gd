extends Node2D
class_name Collectable

@export var healthbox: HealthBox


func _ready() -> void:
	healthbox.died.connect(give_item)


func give_item() -> void:
	pass
