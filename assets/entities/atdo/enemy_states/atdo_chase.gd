extends State

@export var enemy: ATDO
@export var detectionArea: Area3D
@export var raycast: RayCast3D

var direction: Vector3
var speed: float
var player: Player

#TODO: Implement raycasts to avoid obstacles
#	1) Use raycast to move around obstacle (might need to make new state)

func initialize():
	detectionArea.connect("player_detected", Callable(self, "on_player_detected"))

## Update every frame
#func update(delta) -> void:
	##TODO: Use raycast to avoid obstacles
	#pass
	
# Process physics
func update_physics(delta) -> void:
	# Follow player
	enemy.follow_player(player.global_position, delta)
	
	# Focus raycast at player
	raycast.look_at(player.global_position)

# Get player
func on_player_detected(player):
	self.player = player
