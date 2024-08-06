# A projectile emitted by a weapon
extends Area3D
class_name Bullet

@export var damage: int = 25
var initialVelocity: Vector3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += initialVelocity * delta

func _on_body_entered(body):
	queue_free()
