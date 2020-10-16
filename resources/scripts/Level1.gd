extends Level


func _ready():
	player = $Player
	camera = $CameraFollow
	camera.set_target_node(player)
