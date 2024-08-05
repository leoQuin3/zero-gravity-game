extends State

@export var enemy: ATDO
@export var detectionArea: Area3D
@export var weaponHolder: Node3D
@export var raycast: RayCast3D

var prevState: State
var player: Player

#TODO: use signal to pass in player from previous state

func enter() -> void:
	pass
	
func exit() -> void:
	pass

# Update every frame
func update(delta) -> void:
	# Return until player is detected
	if !player:
		return
	
	# Follow Player
	weaponHolder.look_at(player.global_position, Vector3.UP, true)
	
func update_physics(delta) -> void:
	# Move towards player
	enemy.chase_player(player.global_position, delta)
