extends Node2D


@export var entity: Node
@export var healthbox: HealthBox

@export var items: Array[PackedScene]
@export var chances: Array[float]
@export var amounts: Array[int]

var deviation: float = 0.3


func _ready() -> void:
	healthbox.died.connect(loot)


func loot() -> void:
	for i in range(len(items)):
		if randf_range(1, 100) <= (chances[i] * 100):
			var inst: Node

			var dev: int = 0

			if amounts[i] >= 100:
				dev = 30
			elif amounts[i] >= 25:
				dev = 5
			elif amounts[i] >= 10:
				dev = 3
			elif amounts[i] >= 3:
				dev = 2
			
			for j in range(randi_range(amounts[i] - dev, amounts[i] + dev)):
				inst = items[i].instantiate()
				inst.position = entity.position
				entity.get_parent().add_child(inst)
