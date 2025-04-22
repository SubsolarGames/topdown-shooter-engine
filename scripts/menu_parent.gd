extends Node2D
class_name MenuParent


func change_scene(scene_name: String) -> void:
    Globals.ui.get_node("anim").play_backwards("forward")
    get_tree().create_timer(0.5).timeout.connect(func():
        get_tree().change_scene_to_file("res://scenes/" + scene_name + ".tscn")
    )
