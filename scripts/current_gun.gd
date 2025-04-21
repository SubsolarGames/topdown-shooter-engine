extends Sprite2D


func _process(delta):
    if texture != Globals.player.gun.texture:
        texture = Globals.player.gun.texture