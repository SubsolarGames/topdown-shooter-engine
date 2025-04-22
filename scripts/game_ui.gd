extends VBoxContainer


func _process(_delta: float) -> void:
    if Globals.player == null:
        visible = false
    else:
        visible = true