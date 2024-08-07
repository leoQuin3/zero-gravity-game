extends State

@export var enemy: ATDO
@export var detectionArea: Area3D

var direction: Vector3
var speed: float
var player: Player

#TODO: Implement raycasts to avoid obstacles

func initialize():
	detectionArea.connect("player_detected", Callable(self, "on_player_detected"))

func enter() -> void:
	detectionArea.connect("player_detected", Callable(self, "on_player_detected"))
	
func exit() -> void:
	detectionArea.disconnect("player_detected", Callable(self, "on_player_detected"))

# Update every frame
func update(delta) -> void:
	pass
	
# Process physics
func update_physics(delta) -> void:
	# Follow player
	enemy.follow_player(player.global_position, delta)

func on_player_detected(player):
	self.player = player
