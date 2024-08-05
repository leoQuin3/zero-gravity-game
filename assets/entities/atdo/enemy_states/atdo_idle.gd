extends State

@export var enemy: ATDO
@export var detectionArea: Area3D

func initialize() -> void:
	pass

func enter() -> void:
	pass
	
func exit() -> void:
	pass

func update(delta) -> void:
	pass

# Wonder randomly
func update_physics(delta) -> void:
	pass

# Get player within detection area
func on_player_detected(body):
	pass
