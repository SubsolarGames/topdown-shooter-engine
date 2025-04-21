extends Collectable


func give_item() -> void:
	Globals.player.healthbox.health += 1
	Globals.player.healthbox.health = min(Globals.player.healthbox.health, Globals.player.healthbox.max_health)
