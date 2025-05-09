extends Node2D
class_name Player

@export var moveable: Moveable
@export var animated_character: AnimatedCharacter
@export var dust_particle: CPUParticles2D
@export var dash_effect_scene: PackedScene
@export var dash_particle: CPUParticles2D
@export var healthbox: HealthBox
@export var normal_texture: Texture2D
@export var weak_texture: Texture2D
@export var max_dashes: int = 3
@export var guns: Array[PackedScene]

var gun: Gun
var gun_index: int = 0
var target_mod: float = 1.0
var invinc: bool = false
var dashes: int = 3


func _ready() -> void:
    update_gun()
    Globals.player = self
    healthbox.take_damage.connect(on_hit)
    healthbox.died.connect(on_die)


func _process(delta: float) -> void:
    gun.target = get_global_mouse_position()
    move_around(delta)
    animated_character.animate()
    animate_modulate(delta)

    if $animated_character.texture == weak_texture and dashes > 0:
        $animated_character.texture = normal_texture

    scroll_guns()
    dash_action()
    shoot_action()


func move_around(delta: float) -> void:
    var direction: Vector2 = Input.get_vector("left", "right", "up", "down")
    if direction != Vector2.ZERO:
        dust_particle.emitting = true
        moveable.accel_direction(direction, delta)
    else:
        dust_particle.emitting = false
        moveable.add_friction(delta)


func shoot_action() -> void:
    if Input.is_action_pressed("shoot"):
        gun.shoot()
        moveable.slowdown = gun.slowdown
    else:
        moveable.slowdown = 0

    if moveable.state == moveable.STATES.dashing:
        dash_particle.rotation = animated_character.rotation - deg_to_rad(90)
        dash_particle.emitting = true

        if $spawn_dash_ghost.time_left == 0:
            $spawn_dash_ghost.start()
            var dash_inst: Node2D = dash_effect_scene.instantiate()
            dash_inst.rotation = animated_character.rotation
            dash_inst.position = position
            dash_inst.scale = animated_character.scale
            get_parent().add_child(dash_inst)
    else:
        dash_particle.rotation = moveable.velocity.angle()
        dash_particle.emitting = false


func dash_action() -> void:
    if Input.is_action_just_pressed("dash"):
        if dashes > 0:
            if $dash_regen.time_left == 0.0:
                $dash_regen.start()

            healthbox.invinc = true
            get_tree().create_timer(0.0006 * moveable.dash_speed).timeout.connect(func():
                if not invinc:
                    healthbox.invinc = false)

            Globals.camera.screenshake(0.3, 1)
            $spawn_dash_ghost.start()
            moveable.dash()
            dashes -= 1

            if dashes == 0:
                $animated_character.texture = weak_texture
        else:
            AudioManager.play_sound(SoundEffect.SOUND_EFFECT_TYPE.DASH_FAIL, position)


func animate_modulate(delta: float) -> void:
    modulate.a = lerp(modulate.a, target_mod, 10 * delta)
    animated_character.material.set_shader_parameter("alpha", modulate.a)
    if invinc and abs(modulate.a - target_mod) < 0.05:
        target_mod = 1.0 if target_mod == 0.0 else 0.0


func scroll_guns() -> void:
    if Input.is_action_just_pressed("scroll up"):
        AudioManager.play_sound(SoundEffect.SOUND_EFFECT_TYPE.SWITCH_GUN, position)
        gun_index = (gun_index + 1) % len(guns)
        update_gun()

    if Input.is_action_just_pressed("scroll down"):
        AudioManager.play_sound(SoundEffect.SOUND_EFFECT_TYPE.SWITCH_GUN, position)
        gun_index = (gun_index - 1) % len(guns)
        update_gun()


func _on_dash_regen_timeout() -> void:
    dashes += 1
    if dashes < max_dashes:
        $dash_regen.start()


func on_hit() -> void:
    invinc = true
    healthbox.invinc = true
    target_mod = 0.0

    get_tree().create_timer(1.0).timeout.connect(func():
        healthbox.invinc = false
        invinc = false
        target_mod = 1.0)

    Globals.hit_effect(0.1)


func on_die() -> void:
    Globals.ui.get_node("anim").play_backwards("forward")
    invinc = true
    get_tree().create_timer(0.5).timeout.connect(func():
        Globals.reset()
        get_tree().reload_current_scene())


func update_gun() -> void:
    if gun:
        gun.queue_free()

    var inst: Gun = guns[gun_index].instantiate()
    inst.entity = self
    inst.look_at(get_global_mouse_position())
    gun = inst
    add_child(inst)
