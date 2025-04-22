extends HBoxContainer


signal new_value(value)

@export var text: String = 'example'


func _ready() -> void:
    $Label.text = text


func _on_h_slider_drag_started() -> void:
    AudioManager.play_sound(SoundEffect.SOUND_EFFECT_TYPE.BUTTON, position)


func _on_h_slider_drag_ended(value_changed:bool) -> void:
    AudioManager.play_sound(SoundEffect.SOUND_EFFECT_TYPE.BUTTON, position)


func set_slider(value: float) -> void:
    $HSlider.value = value


func _on_h_slider_value_changed(value:float) -> void:
    new_value.emit(value)
