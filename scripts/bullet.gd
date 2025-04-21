extends Node2D


@export var particle_scene: PackedScene
@export var piercing: bool = false
@export var particle_color: Color

var dir: float = 0.0
var speed: float = 0.0


func _ready() -> void:
    if not piercing:
        $damagebox.damaged.connect(destroy)

    $moveable.collided.connect(destroy)
    $moveable.velocity = Vector2(speed, 0).rotated(dir)


func destroy() -> void:
    Globals.camera.screenshake(0.05, 1)

    var particle_inst: CPUParticles2D = particle_scene.instantiate()
    particle_inst.rotation = $moveable.velocity.angle()
    particle_inst.position = global_position
    particle_inst.color = particle_color
    get_parent().add_child(particle_inst)

    queue_free()