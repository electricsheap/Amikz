class_name Pathfind
extends Node2D

export (float) var grid_size = 8

onready var collider: KinematicBody2D = $Collider
var target: Vector2 = Vector2.ZERO
var path: Path2D = Path2D.new()

func set_target( vec: Vector2 ):
	target = vec

#func set_collider( vec: KinematicBody2D ):
#	target = vec

func test( travel: Vector2 ):
	return collider.test_move( collider.transform, travel, true )

func find() -> Vector2:
	var travel = Vector2.ZERO
	var dist = (target - position).abs()
	while true:
		if test( travel ):
			travel += (dist/grid_size).round() * grid_size
		else:
			return travel
	return Vector2.ZERO
