extends MenuParent


func _ready() -> void:
	$CanvasLayer/MarginContainer/VBoxContainer/slider.set_slider(Globals.screenshake_mul * 50)
	$CanvasLayer/MarginContainer/VBoxContainer/slider2.set_slider(db_to_linear(Globals.music_volume))
	$CanvasLayer/MarginContainer/VBoxContainer/slider2.get_node("HSlider").min_value = 0.0
	$CanvasLayer/MarginContainer/VBoxContainer/slider2.get_node("HSlider").max_value = 1.0

	$CanvasLayer/MarginContainer/VBoxContainer/slider3.set_slider(db_to_linear(Globals.sfx_volume))
	$CanvasLayer/MarginContainer/VBoxContainer/slider3.get_node("HSlider").min_value = 0.0
	$CanvasLayer/MarginContainer/VBoxContainer/slider3.get_node("HSlider").max_value = 1.0


func _on_button_pressed() -> void:
	change_scene("main_menu")


func _on_slider_new_value(value:Variant) -> void:
	Globals.screenshake_mul = (value / 50.0)


func _on_slider_2_new_value(value: Variant) -> void:
	Globals.music_volume = linear_to_db(value)


func _on_slider_3_new_value(value: Variant) -> void:
	Globals.sfx_volume = linear_to_db(value)
