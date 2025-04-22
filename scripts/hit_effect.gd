extends ColorRect


var alpha_value: float = 0.0


func _process(delta: float) -> void:
    if Globals.hit_effect_value == 1.0:
        alpha_value = 1.0
    else:
        alpha_value = lerp(alpha_value, Globals.hit_effect_value, 10 * delta)

    material.set_shader_parameter("vignette_opacity", alpha_value + Globals.hit_perm_value)