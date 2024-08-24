# A projectile emitted by a weapon
extends Area3D
class_name Bullet

@export var damage: int = 25

# Exclude shooter from detection
@export var shooter: CollisionObject3D

var initialVelocity: Vector3

# Update motion
func _physics_process(delta):
	position += initialVelocity * delta

# Damage entities
func _on_body_entered(body):
	# Prevent detection of shooter
	if body != shooter:
		if body.has_method("take_damage"):
			body.take_damage(damage)
		queue_free()
