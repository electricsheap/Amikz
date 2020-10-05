class_name Player
extends KinematicBody2D

var explosion_packed = preload("res://scenes/effects/Explosion.tscn")
var spark_packed = preload("res://scenes/effects/Spark.tscn")
export var speed := 150.0;

func get_dir() -> Vector2:
	return Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)

func explode():
	var explosion = explosion_packed.instance()
	explosion.position = self.position
	var par = get_parent()
	par.add_child(explosion)
	par.remove_child(self)
	queue_free()

func spark(where: Vector2):
	var spark = spark_packed.instance()
	spark.position = where
	spark.emitting = true
	add_child(spark)

func _physics_process(delta):
	var dir = get_dir().normalized()
	
	move_and_slide( dir * speed, Vector2.ZERO, false, 4, 0.9, false )
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		var collider = collision.collider
		if  dir.length() * speed > 1.0: spark(collision.position - self.position)
		if collider is RigidBody2D:
			collider.apply_impulse( collision.position - collider.position, -collision.normal * dir.length() * speed * 0.1) 
