extends Node2D


@export var healthbox: HealthBox
@export var entity: Node

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
   
			for j in range(randf_range(ceil(amounts[i] - (amounts[i]*0.3)), floor(amounts[i] + (amounts[i]*0.3)))):
				inst = items[i].instantiate()
				inst.position = entity.position
				entity.get_parent().add_child(inst)
