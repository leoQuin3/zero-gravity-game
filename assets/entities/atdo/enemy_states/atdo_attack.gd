extends State

@export var enemy: ATDO
@export var detectionArea: Area3D
@export var weaponHolder: Node3D
@export var raycast: RayCast3D

var prevState: State
var player: Player

func enter() -> void:
	prevState = fsm.get_previous_state()
	prevState.connect("player_detected", Callable(self, "on_player_detected"))
	
	print("enter()")
	
func exit() -> void:
	pass

# Aim raycast towards player
func update(delta) -> void:
	weaponHolder.look_at(player.global_position, Vector3.UP, true)
	
	var collider: = raycast.get_collider()
	print("update(). Curr collider: " + str(collider) + ". Orientation: " + str(weaponHolder.rotation))
	
func update_physics(delta) -> void:
	# Move towards player
	print("update_physics(). Curr player " + str(player))
	enemy.chase_player(player.global_position, delta)
	
	#TODO: Add raycast to switch state to idle if player obscured by a wall

func on_player_detected(player):
	print("on_player_detected")
	self.player = player
	weaponHolder.look_at(player.global_position, Vector3.UP, true)
