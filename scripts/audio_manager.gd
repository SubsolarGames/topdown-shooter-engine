extends Node2D 


@export var sound_effects: Array[SoundEffect]

var sound_effect_dict: Dictionary = {}


func _ready() -> void:
	for sound_effect: SoundEffect in sound_effects:
		sound_effect_dict[sound_effect.type] = sound_effect


func play_sound(sound_name: SoundEffect.SOUND_EFFECT_TYPE, pos: Vector2) -> void:
	var sound: SoundEffect = sound_effect_dict[sound_name]

	var inst_sound: AudioStreamPlayer2D = AudioStreamPlayer2D.new()

	inst_sound.position = pos
	inst_sound.stream = sound.sound_effect
	inst_sound.volume_db = sound.volume + Globals.sfx_volume
	inst_sound.pitch_scale = randf_range(1 - sound.pitch_var, 1 + sound.pitch_var)
	inst_sound.finished.connect(inst_sound.queue_free)

	add_child(inst_sound)

	inst_sound.play()
