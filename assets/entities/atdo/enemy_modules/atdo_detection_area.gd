extends Area3D

signal player_detected(player: Player)
signal body_detected(body)

func _ready():
	self.connect("body_entered", Callable(self, "on_body_entered"))

func on_body_entered(body):
	if body is Player:
		emit_signal("player_detected", body)
	elif body:
		emit_signal("body_detected", body)
