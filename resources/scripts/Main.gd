extends Node2D

onready var current_level: Level = $Level

func _ready():
	pass

func _on_change_level(which, passage):
	var packed_level: PackedScene = load("res://scenes/levels/" + which + ".tscn")
	
	if packed_level == null:
		printerr("Error: level \"" + which + "\" could not be loaded from res://scenes/levels/" + which + ".tscn")
		return
	
	var level: Level = packed_level.instance()
	if not (level is Level):
		printerr("Error: scene \"" + which + "\" at res://scenes/levels/" + which + ".tscn is not of type Level. Make sure it extends the Level.gd script")
		return
	
	current_level.disconnect("change_level", self, "_on_change_level")
	remove_child(current_level)
	current_level.call_deferred("queue_free")
	
	level.connect("change_level", self, "_on_change_level")
	add_child(level)
	current_level = level
