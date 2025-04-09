extends Sprite2D
class_name AnimatedCharacter

@export var moveable: Moveable


func animate() -> void:
    if moveable.state == moveable.STATES.moving:
        $AnimationPlayer.play("walk")

        if moveable.velocity.x > 0:
            flip_h = false
        if moveable.velocity.x < 0:
            flip_h = true

    elif moveable.state == moveable.STATES.still:
        $AnimationPlayer.play("idle")

    elif moveable.state == moveable.STATES.dashing:
        $AnimationPlayer.stop()

        rotation_degrees = rad_to_deg((moveable.velocity).angle()) + 90
        scale = Vector2(0.5, 0.5) + (abs(Vector2(0, moveable.velocity.length()))/200.0)