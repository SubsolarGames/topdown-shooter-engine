extends Resource
class_name SoundEffect 


enum SOUND_EFFECT_TYPE {
    BUTTON,
    COIN_GET,
    HEART_GET,
    DASH,
    DASH_FAIL,
    ENEMY_DASH,
    PLAYER_DIE,
    ENEMY_DIE,
    PLAYER_TAKE_DAMAGE,
    ENEMY_TAKE_DAMAGE,
    ROCK_TAKE_DAMAGE,
    EXPLOSION,
    OPEN_CHEST,
    OPEN_PORTAL,
    PICKUP_GUN,
    SHOOT,
    SHOOT2,
    SWITCH_GUN
}

@export var type: SOUND_EFFECT_TYPE
@export var sound_effect: AudioStream
@export_range(-40, 20) var volume: float = 0
@export_range(0.0, 1.0,.01) var pitch_var: float = 0.2