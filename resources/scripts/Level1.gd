extends Level

onready var cam = $CameraFollow


func _ready():
	cam.set_target_node($Player)
	
	
