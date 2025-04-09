extends Camera2D


var noise = FastNoiseLite.new()
var noise_ticker: float = 0.0

var shake_ticker: float = 0.0
var shake_size: float = 0.0
var shake_speed: float = 0.0



func _ready() -> void:
    Globals.camera = self


func screenshake(duration, size, speed=1000) -> void:
    shake_ticker += max(duration - shake_ticker, 0)
    shake_size = size
    shake_speed = speed


func _process(delta: float) -> void:
    offset = Vector2(noise.get_noise_2d(1, noise_ticker), noise.get_noise_2d(100, noise_ticker)) * shake_size
    noise_ticker += delta * shake_speed

    if shake_ticker > 0:
        shake_ticker -= delta
    else:
        shake_size = 0.0

