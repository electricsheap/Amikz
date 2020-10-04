class_name Level
extends CanvasLayer

signal change_level( which, passage )

var player: Player;

func _get_configuration_warning():
	var flag := false
	for child in get_children():
		flag = child is CanvasLayer
	return "" #if flag else "you need to add a cavanas layer"
	
