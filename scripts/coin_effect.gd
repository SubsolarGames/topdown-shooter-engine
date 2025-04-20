extends Sprite2D


func _ready() -> void:
	get_tree().create_timer(1.0).timeout.connect(func():
		queue_free())


func _process(delta: float) -> void:
	position = lerp(position, Globals.coin_effect_pos, 5 * delta)
