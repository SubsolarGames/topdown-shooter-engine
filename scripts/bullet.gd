extends Node2D


@export var particle_scene: PackedScene

var dir: float = 0.0
var speed: float = 0.0


func _ready() -> void:
    $moveable.collided.connect(destroy)
    $damagebox.damaged.connect(destroy)
    $moveable.velocity = Vector2(speed, 0).rotated(dir)


func destroy() -> void:
    Globals.camera.screenshake(0.2, 1)

    var particle_inst: CPUParticles2D = particle_scene.instantiate()
    particle_inst.rotation = $moveable.velocity.angle()
    particle_inst.position = global_position
    get_parent().add_child(particle_inst)

    queue_free()