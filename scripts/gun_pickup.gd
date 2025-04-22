extends Interactable


@export var gun_scene: PackedScene


func give_item() -> void:
	Globals.player.guns.append(gun_scene)
	Globals.player.gun_index = len(Globals.player.guns) - 1
	Globals.player.update_gun()
