extends Node2D
class_name Level


signal change_scene


func start() -> void:
	Globals.player.position = $start_pos.position
	$AudioStreamPlayer.volume_db += Globals.music_volume


func _on_exit_exited() -> void:
	change_scene.emit()
