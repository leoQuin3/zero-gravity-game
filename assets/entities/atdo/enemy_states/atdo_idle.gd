extends State

@export var enemy: ATDO
@export var detectionArea: Area3D

signal player_detected(player: Player)

func initialize() -> void:
	pass

func enter() -> void:
	detectionArea.connect("body_entered", Callable(self, "on_player_detected"))
	
func exit() -> void:
	pass

func update(delta) -> void:
	pass

# Wonder randomly
func update_physics(delta) -> void:
	pass

# Get player within detection area
func on_player_detected(body):
	print("Alert! " + str(body) + " has been detected!")
	
	# Emit signals to change state and pass in player node
	emit_signal("state_transitioned", "CHASE")
	emit_signal("player_detected", body)
	
	# Disconnect signal to prevent being called again
	detectionArea.disconnect("body_entered", Callable(self, "on_player_detected"))
