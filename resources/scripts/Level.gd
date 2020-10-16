class_name Level
extends CanvasLayer

signal change_level( which, passage )

onready var player: Player = get_node("Player")
onready var camera: CameraFollow = get_node("CameraFollow")
onready var screen_dim: Vector2


var mouse_pos := Vector2.ZERO

func _ready():
	screen_dim = get_viewport().size

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
#			print(
#				get_viewport().get_mouse_position(), 
#				camera.position,
#				get_viewport().size/2
#			)
			player.set_staff_target( 
				get_viewport().get_mouse_position() + 
				camera.position -
				get_viewport().size/2
				)
 
func _get_configuration_warning():
	var flag := false
	for child in get_children():
		flag = child is CanvasLayer
	return "" #if flag else "you need to add a cavanas layer"
	
