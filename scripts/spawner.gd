extends Node2D
class_name Spawner

@export var entity: Node2D
@export var obj: PackedScene


func spawn_obj(obj_position: Vector2 = Vector2.ZERO, obj_rotation: float = 0, obj_scale: Vector2 = Vector2.ONE, obj_modulate: Color = Color(1, 1, 1, 1) ):
    var inst: Node2D = obj.instantiate()
    inst.position = obj_position
    inst.scale = obj_scale
    inst.rotation = obj_rotation
    inst.modulate = obj_modulate
    entity.get_parent().add_child(inst)