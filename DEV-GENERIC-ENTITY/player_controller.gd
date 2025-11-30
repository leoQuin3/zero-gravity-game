extends GenericController
class_name PlayerController

@export var camera: CameraModule

# --------------------- Puppet Method Callers (TO DEFINE) ---------------------
# User input controls the actions of the player character

# Control player movement
func control_move(delta) -> void:
	var inputVector: Vector2 = Input.get_vector("left", "right", "forward", "back")
	var player_dir: Vector3 = (camera.getCameraBasis() * Vector3(inputVector.x, 0 , inputVector.y)).normalized()
	player_dir.y = 0
	player_dir = player_dir.normalized()
	
	puppet.move(player_dir, delta)

# Control player jump
func control_jump(delta) -> void:
	if Input.is_action_just_pressed("jump"):
		puppet.jump(delta)
