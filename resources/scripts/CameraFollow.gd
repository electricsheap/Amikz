class_name CameraFollow
extends Camera2D


export (bool) var will_snap := true
export (Vector2) var leash := Vector2(30, 30)
export (bool) var circular := false

var parallax := Vector2(1.0,1.0)

onready var leash_len := leash.length()
var target: Node2D

func _ready():
	if will_snap:
		snap_to_target()



func _physics_process(delta):
	
	if target != null:
		if circular:
			var diff = target.position - self.position
			var diff_len = diff.length()
			if diff_len > leash_len:
				var leashed = diff * (( diff_len - leash_len ) / diff_len )
				self.position += max_vec2( leashed/4, leashed.clamped(2) )
		else:
#			var leashed
#			var dpos = target.position - self.position
#			var dx = target.position.x - self.position.x
#			var dy = target.position.y - self.position.y
#			
#			if abs( dx ) > leash.x:
#				leashed = dx * (( abs( dx ) - leash.x ) / abs( dx ))
#				self.position.x += max( leashed/4, min( 2, leashed ))
#			if abs( dy ) > leash.y:
#				leashed = dy * (( abs( dy ) - leash.y ) / abs( dy ))
#				self.position.y += max( leashed/4, min( 2, leashed ))
			var dpos = parallax * ( target.position - self.position )
			var leashed = dpos * (( dpos.abs() - leash ) / dpos.abs() )
			if abs( dpos.x ) > leash.x:
				self.position.x += max( leashed.x/4, min( 2, leashed.x ))
			if abs( dpos.y ) > leash.y:
				self.position.y += max( leashed.y/4, min( 2, leashed.y ))


func max_abs( a, b ):
	return a if abs(a) > abs(b) else b

func min_abs( a, b ):
	return a if abs(a) < abs(b) else b

func snap_to_target():
	if target != null:
		self.position = target.position * parallax

func set_target_node(node, snap = self.will_snap, parallax = Vector2(1.0,1.0) ):
	self.target = node
	if will_snap:
		snap_to_target()
	set_parallax( parallax )

func set_parallax( vec2: Vector2 ):
	self.parallax = vec2

func min_vec2( a: Vector2, b: Vector2 ) -> Vector2:
	return a if ( b.length_squared() - a.length_squared() ) > 0.0 else b
	
func max_vec2( a: Vector2, b: Vector2 ) -> Vector2:
	return a if ( a.length_squared() - b.length_squared() ) > 0.0 else b
