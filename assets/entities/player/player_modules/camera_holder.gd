extends Node3D

@export var parent: Player

@export_category("Mouse settings")
@export var MOUSE_IS_CAPTURED: bool = true
@export var CAMERA_SENSITIVITY: float = 0.003

#FIXME: Pass in delta and call under _process() to fix stuttering

func fp_camera_look(event: InputEventMouseMotion, minPitch: float, maxPitch: float):
	var newPitch = event.relative.y
	var newYaw = event.relative.x
	
	#Update camera pitch and player yaw.
	self.rotation.x -= newPitch * CAMERA_SENSITIVITY
	parent.rotation.y -= newYaw * CAMERA_SENSITIVITY
	
	# Cap camera pitch.
	self.rotation.x = clamp(self.rotation.x, minPitch, maxPitch)
