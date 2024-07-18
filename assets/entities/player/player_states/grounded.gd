extends State

func enter() -> void:
	pass

func exit() -> void:
	pass

func initialize() -> void:
	pass

func update(delta) -> void:
	pass

func update_physics(delta) -> void:
	pass

func handle_input(event) -> void:
	pass
	#if event is InputEventMouseMotion:
		#var newPitch = event.relative.y
		#var newYaw = event.relative.x
		#
		##Update camera pitch and player yaw
		#cameraHead.rotation.x -= newPitch * CAMERA_SENSITIVITY
		#self.rotation.y -= newYaw * CAMERA_SENSITIVITY
		#
		## Cap camera pitch
		#cameraHead.rotation.x = clamp(cameraHead.rotation.x, deg_to_rad(-90), deg_to_rad(90))
