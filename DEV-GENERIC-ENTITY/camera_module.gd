# The camera module that allows the player to look around
extends Node3D
class_name CameraModule

@export var CAMERA_SENSITIVITY: float = 0.003
var mouseFirstTime: bool = true

const MAX_PITCH: float = 89.9
const MIN_PITCH: float = -89.9

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

# Camera movement using mouse position
func _unhandled_input(event):
	# Prevent jerk on first frame
	if mouseFirstTime:
		mouseFirstTime = false
		return
	
	if event is InputEventMouseMotion:
		var newPitch = event.relative.y
		var newYaw = event.relative.x
		
		#Update camera pitch
		self.rotation.x -= newPitch * CAMERA_SENSITIVITY
		self.rotation.y -= newYaw * CAMERA_SENSITIVITY
		
		# Cap camera pitch
		rotation.x = clamp(rotation.x, deg_to_rad(MIN_PITCH), deg_to_rad(MAX_PITCH))

func getCameraBasis() -> Basis:
	return global_basis
