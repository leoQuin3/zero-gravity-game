extends State

@export var enemy: ATDO
@export var detectionArea: Area3D

func enter() -> void:
	print("ATDO is Waiting...")
	
func exit() -> void:
	pass

func update(delta) -> void:
	pass

# Wonder randomly
func update_physics(delta) -> void:
	pass

# Get player within detection area
func _on_detection_area_body_entered(body):
	#TODO: Add raycast to switch state to chase if player isn't obscured by a wall
	
	#FIXME: If there's a way to pass player to next state, write it here.
	emit_signal("state_transitioned", "CHASE")
