extends Area3D

signal player_detected

# Player being observed
var player: Player

# Get Player node and send signal
func _on_body_entered(body):
	if body is Player:
		player = body
		emit_signal("player_detected")
