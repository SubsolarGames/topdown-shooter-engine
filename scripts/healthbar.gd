extends TextureProgressBar


func _process(delta: float) -> void:
	if Globals.player != null:
		value = lerp(value, 100 * (Globals.player.healthbox.health / Globals.player.healthbox.max_health), 5 * delta)

		if Globals.player.healthbox.health <= (Globals.player.healthbox.max_health * 0.1) or Globals.player.healthbox.health < 1.0:
			Globals.hit_perm_value = 0.5
		else:
			Globals.hit_perm_value = 0.0
