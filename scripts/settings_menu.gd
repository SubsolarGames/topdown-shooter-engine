extends MenuParent


func _ready() -> void:
	$CanvasLayer/MarginContainer/VBoxContainer/slider.set_slider(Globals.screenshake_mul * 50)
	$CanvasLayer/MarginContainer/VBoxContainer/slider2.set_slider((db_to_linear(Globals.music_volume) * 100) - 50)
	$CanvasLayer/MarginContainer/VBoxContainer/slider3.set_slider((db_to_linear(Globals.sfx_volume) * 100) - 50)


func _on_button_pressed() -> void:
	change_scene("main_menu")


func _on_slider_new_value(value:Variant) -> void:
	Globals.screenshake_mul = (value / 50.0)


func _on_slider_2_new_value(value: Variant) -> void:
	Globals.music_volume = linear_to_db((value + 50) / 100)


func _on_slider_3_new_value(value: Variant) -> void:
	Globals.sfx_volume = linear_to_db((value + 50) / 100)
