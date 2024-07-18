extends State

@export var parent: Player

func enter() -> void:
	#TODO: delete this print statement
	print("entered state: " + str(self))

func exit() -> void:
	#TODO: delete this print statement
	print("bye bye!")

func initialize() -> void:
	if parent.MOUSE_IS_CAPTURED:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func update(delta) -> void:
	pass
	
func update_physics(delta) -> void:
	parent.player_control_move(delta)
	
func handle_input(event) -> void:
	parent.fp_camera_look(event, deg_to_rad(-90), deg_to_rad(90))
