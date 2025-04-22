extends Node2D
class_name Gun


@export var entity: Node
@export var bullet_scene: PackedScene
@export var shell_scene: PackedScene
@export var speed: float = 200.0
@export var bullets: int = 3
@export var innac: float = 0
@export var spread: float = 30.0
@export var fire_rate: float = 0.2
@export var slowdown: float = 100.0
@export var shoot_sound: SoundEffect.SOUND_EFFECT_TYPE = SoundEffect.SOUND_EFFECT_TYPE.SHOOT

var texture: Texture2D
var target: Vector2 = Vector2.ZERO
var offset: Vector2= Vector2.ZERO


func _ready() -> void:
	texture = $Sprite2D.texture
	$fire_rate.wait_time = fire_rate


func _process(_delta: float) -> void:
	offset = $Sprite2D.offset.rotated(rotation)

	look_at(target)

	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1


func shoot() -> void:
	if $fire_rate.time_left == 0.0 and $anim.current_animation != "appear":
		AudioManager.play_sound(shoot_sound, position)
		$fire_rate.start()

		$anim.speed_scale = 1.5
		$anim.play("fire")

		var shell_inst: CPUParticles2D = shell_scene.instantiate()
		shell_inst.position = $Sprite2D.global_position
		shell_inst.rotation = (global_position).angle_to_point(target)
		entity.get_parent().add_child(shell_inst)

		var angle: float = 0.0
		var angle_dir: int = 1

		for i in range(bullets):

			var mod_angle: float = angle + randf_range(-innac, innac) + rad_to_deg((global_position).angle_to_point(target))
			var inst: Node2D = bullet_scene.instantiate()
			inst.position = $Sprite2D/muzzle_flash.global_position
			inst.rotation_degrees = mod_angle
			inst.dir = deg_to_rad(mod_angle)
			inst.speed = speed
			entity.get_parent().add_child(inst)

			angle += angle_dir * ((spread/bullets) * (i+1))
			angle_dir *= -1
