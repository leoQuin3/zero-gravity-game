extends Area3D

signal player_detected(player: Player)

var entityDetected

# Connect signal
func _ready():
	self.connect("body_entered", Callable(self, "_on_entity_entered"))

# Get Player node and send signal
func _on_entity_entered(body):
	if body is Player:
		entityDetected = body
		emit_signal("player_detected", body)
