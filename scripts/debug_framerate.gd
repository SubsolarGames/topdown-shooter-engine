extends Label


func _process(_delta: float) -> void:
    text = "Frame rate: " + str(Engine.get_frames_per_second())