extends State

@export var enemy: ATDO
var player: Player

func enter() -> void:
	enemy.velocity = Vector3.ZERO
	
func exit() -> void:
	pass

# Update every frame
func update(delta) -> void:
	pass
	
# Process physics
func update_physics(delta) -> void:
	# Follow player
	enemy.follow_player(player.global_position, delta)
	pass
