extends Sprite2D


func _process(_delta):
	if Globals.player:
		if texture != Globals.player.gun.texture:
			texture = Globals.player.gun.texture
