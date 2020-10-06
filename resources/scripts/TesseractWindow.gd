class_name TesseractWindow
extends Polygon2D

export var power: float = -1.0;

func _ready():
	pass



func _process( delta ):
	power += delta/4
	material.set_shader_param("global_transform", get_global_transform())
	material.set_shader_param("power", self.power)
