extends Collectable


@export var coin_effect_scene: PackedScene


func give_item() -> void:
	var inst = coin_effect_scene.instantiate()
	inst.position = self.get_global_transform_with_canvas().origin - Globals.ui.transform.origin
	Globals.ui.add_child(inst)

	Globals.coins += 1
