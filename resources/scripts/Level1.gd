extends Level

onready var fractal = $Frac

func _ready():
	player = $Player
	camera = $CameraFollow
	camera.set_target_node(player)



func _process(delta):
	fractal.material.set_shader_param("var", player.position/250
	)
