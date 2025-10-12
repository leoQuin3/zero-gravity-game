# The camera module that allows the player to look around
extends Node3D
class_name CameraHolder

@export var parent: Player

@export_category("Mouse settings")
@export var MOUSE_IS_CAPTURED: bool = true
@export var CAMERA_SENSITIVITY: float = 0.003

var mouseFirstTime: bool = true

# Camera movement
func fp_camera_look(event: InputEventMouseMotion, minPitch: float, maxPitch: float):
	# Prevent jerk on first frame
	if mouseFirstTime:
		mouseFirstTime = false
		return
	
	var newPitch = event.relative.y
	var newYaw = event.relative.x
	
	#Update camera pitch and player yaw.
	self.rotation.x -= newPitch * CAMERA_SENSITIVITY
	parent.rotation.y -= newYaw * CAMERA_SENSITIVITY
	
	# Cap camera pitch.
	self.rotation.x = clamp(self.rotation.x, minPitch, maxPitch)
