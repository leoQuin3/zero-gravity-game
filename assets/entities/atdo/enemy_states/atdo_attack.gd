extends State

@export var enemy: ATDO
@export var detectionArea: Area3D
var player: Player
	
func enter() -> void:
	print("Chasing!")
	pass
	
func exit() -> void:
	pass

func update_physics(delta) -> void:
	# Move towards player
	if player:
		enemy.chase_player(player.global_position, delta)
	
	#TODO: Add raycast to switch state to idle if player obscured by a wall

# Get player within detection area
func _on_detection_area_body_entered(body):
	if body is Player:
		player = body
