# A projectile emitted by a weapon
extends Area3D
class_name Bullet

@export var damage: int = 25
var initialVelocity: Vector3
var shooterCollisionLayer

# Update motion
func _process(delta):
	position += initialVelocity * delta

# Delete bullet upon contact with a body (that isn't from its shooter)
func _on_body_entered(body):
	if body.get_collision_layer() != shooterCollisionLayer:
		queue_free()
