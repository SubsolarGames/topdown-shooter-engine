extends HBoxContainer


@export var icon_scene: PackedScene
@export var empty_scene: PackedScene

var player_dashes: int = 0


func _process(_delta: float) -> void:
    if Globals.player:
        if player_dashes != Globals.player.dashes:
            player_dashes = Globals.player.dashes

            for i in get_children():
                i.queue_free()

            var inst: Control

            for i in range(player_dashes):
                inst = icon_scene.instantiate()
                add_child(inst)
            
            for i in range(Globals.player.max_dashes - player_dashes):
                inst = empty_scene.instantiate()
                add_child(inst)