extends Control


func _process(delta: float) -> void:
	Globals.coin_effect_pos = ($Sprite2D.global_position + Vector2(4, 4))
