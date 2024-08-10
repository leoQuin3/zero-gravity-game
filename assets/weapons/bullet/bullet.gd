# A projectile emitted by a weapon
extends Area3D
class_name Bullet

@export var damage: int = 25
@export var shooter: CollisionObject3D:
	set(entity):
		# Set shooter
		shooter = entity
		
		# Store collision layer of the shooter
		shooterCollisionLayer = entity.get_collision_layer()
	get:
		# Return shooter by reference
		return shooter

var initialVelocity: Vector3
var shooterCollisionLayer

# Update motion
func _process(delta):
	position += initialVelocity * delta

# Delete bullet upon contact
func _on_body_entered(body):
	# Prevent detection of shooter
	if body.get_collision_layer() != shooterCollisionLayer:
		queue_free()
