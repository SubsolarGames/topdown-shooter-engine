extends Node2D
class_name Level


signal change_scene


func start() -> void:
	Globals.player.position = $start_pos.position


func _on_exit_exited() -> void:
	change_scene.emit()
