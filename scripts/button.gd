extends Button


func _on_pressed() -> void:
	AudioManager.play_sound(SoundEffect.SOUND_EFFECT_TYPE.BUTTON, position)
