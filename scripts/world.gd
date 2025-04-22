extends Node2D


@export var levels: Array[PackedScene]
var current_level: Level
var level: int = 0


func _ready() -> void:
	Globals.world = self
	call_deferred("update_level")


func update_level() -> void:
	if current_level:
		current_level.queue_free()

	var inst: Level = levels[level].instantiate()
	inst.start()
	inst.change_scene.connect(func():
		Globals.ui.get_node("anim").play_backwards("forward")
		Globals.player.invinc = true
		get_tree().create_timer(0.5).timeout.connect(func():
			level += 1
			update_level()
			Globals.player.invinc = false
			Globals.ui.get_node("anim").play("forward"))
		)

	current_level = inst
	add_child(inst)
