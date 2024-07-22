extends State

@export var player: Player
@export var grappleHook: GrapplingHook

func enter() -> void:
	pass

func exit() -> void:
	pass

func initialize() -> void:
	pass

func update(delta) -> void:
	pass

func update_physics(delta) -> void:
	var grapplePoint: Vector3
	if Input.is_action_just_pressed("grapple"):
		pass

func handle_input(event) -> void:
	pass
