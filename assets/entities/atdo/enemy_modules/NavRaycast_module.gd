extends Node3D

signal obstacle_detected(obstacleDir: Vector3)

# Each raycast for each direction
@export var frontRay: RayCast3D
@export var topRay: RayCast3D
@export var bottomRay: RayCast3D
@export var leftRay: RayCast3D
@export var rightRay: RayCast3D

# Calculate direction of obstacle
func _process(delta):
	var xDirection: int =  int(rightRay.is_colliding()) - int(leftRay.is_colliding())
	var yDirection: int =  int(topRay.is_colliding()) - int(bottomRay.is_colliding())
	var zDirection: int =  int(frontRay.is_colliding())
	
	var obstacleDir: Vector3 = Vector3(xDirection, yDirection, zDirection)
	
	# Emit signal returning the obstacle direction
	if obstacleDir:
		emit_signal("obstacle_detected", obstacleDir)
