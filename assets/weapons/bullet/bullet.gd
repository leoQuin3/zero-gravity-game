# A projectile emitted by a weapon
extends Area3D
class_name Bullet

var initialVelocity: Vector3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += initialVelocity * delta
