# Automated Tactical Defense Operator, a handy drone that patrols your base!
extends CharacterBody3D
class_name ATDO

# Parameters
const SPEED: float = 200.0

@export_category("Connect nodes")
@export var healthModule: HealthModule
@export var stateMachine: StateMachine

# Update physics
func _physics_process(delta):
	move_and_slide()

# Move toward Player
func follow_player(playerPosition: Vector3, delta: float) -> void:
	# Get direction vector and apply velocity
	var directionVector: Vector3 = (playerPosition - self.global_position).normalized()
	self.velocity = directionVector * SPEED * delta

# Take damage
func take_damage(amount: int) -> void:
	healthModule.take_damage(amount)

# Delete enemy when health runs out
#TODO: add death animation (eg. explosions)
func _on_health_health_ran_out():
	queue_free()
