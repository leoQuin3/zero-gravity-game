extends State

@export var enemy: ATDO
@export var detectionArea: Area3D
@export var raycast: RayCast3D
var player: Player
	
func enter() -> void:
	print("Chasing!")
	pass
	
func exit() -> void:
	pass

func update_physics(delta) -> void:
	if player:
		enemy.chase_player(player.global_position, delta)

func _on_detection_area_body_entered(body):
	if body is Player:
		player = body
