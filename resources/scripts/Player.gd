class_name Player
extends KinematicBody2D

export var speed := 150.0
export (int) var score := 0
export (float) var hp := 0


var fire_ball_packed = preload("res://scenes/objects/FireBall.tscn")
var velocity := Vector2.ZERO



onready var staff := $Staff

func set_staff_target( pos: Vector2 ):
#	print( position, pos )
	var dir = position - pos
	var fire_ball = fire_ball_packed.instance()
	fire_ball.position = position - dir.normalized() * 30
	fire_ball.velocity = -dir.normalized() * 200
	fire_ball.rotation = fire_ball.velocity.angle() - PI
	get_parent().add_child(fire_ball)
	
	staff.position = - dir.normalized() * 10
	staff.rotation = dir.angle() - PI/2

func get_dir() -> Vector2:
	return Vector2(
		ceil(Input.get_action_strength("game_right")) - ceil(Input.get_action_strength("game_left")),
		Input.get_action_strength("game_down") - Input.get_action_strength("game_up")
	)

var is_diag := false

func _physics_process(delta):
	
	var dir = get_dir()
	velocity = dir * speed
#	print(( position.x - floor(position.x)) - ( position.y - floor(position.y) ))
	if (!is_diag) and ( dir.x * dir.y != 0 ):
		position = Vector2( round( position.x ), round( position.y ))
	is_diag = ( dir.x * dir.y != 0 )
	velocity = move_and_slide_with_snap( velocity, get_floor_normal(), Vector2.ZERO, false, 4, 0.9, false )
	
	
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		var collider = collision.collider
#		if  dir.length() * speed > 1.0: spark(collision.position - self.position)
		if collider is RigidBody2D: pass
#			collider.apply_impulse( collision.position - collider.position, -collision.normal * dir.length() * speed * 0.1) 
