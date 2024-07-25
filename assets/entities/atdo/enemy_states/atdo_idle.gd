extends State

@export var enemy: ATDO
@export var detectionArea: Area3D

func enter() -> void:
	print("ATDO is Waiting...")
	
func exit() -> void:
	pass

func update(delta) -> void:
	pass

func update_physics(delta) -> void:
	pass

func handle_input(event) -> void:
	pass

func _on_detection_area_body_entered(body):
		#FIXME: If there's a way to pass player to next state, write it here.
		emit_signal("state_transitioned", "CHASE")
