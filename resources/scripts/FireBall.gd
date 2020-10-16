extends Area2D

var velocity := Vector2.ZERO
var is_dead;
var death_counter = 0.25
onready var poly := $Polygon2D
onready var parts := $Particles2D

func _ready():
	pass

func _physics_process(delta):
	position += velocity * delta
	
	death_counter -= delta if is_dead else 0
	if death_counter < 0.0:
		queue_free()

func _on_FireBall_body_entered(body):
	if body is TileMap:
		velocity *= 0.5
		poly.visible = false
		parts.emitting = false
		is_dead = true
