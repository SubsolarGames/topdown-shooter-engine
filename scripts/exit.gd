extends Interactable


signal exited


func give_item() -> void:
    exited.emit()