# A General purpose finite state machine

extends Node
class_name StateMachine

@export var initialState: NodePath

var states: Dictionary
var currentState: State

# Initialize states to dictionary
func _ready() -> void:
	# Add children nodes as states
	for node in get_children():
		if node is State:
			states[node.name.to_upper()] = node
			node.fsm = self
			node.state_transitioned.connect(Callable(self, "on_state_changed"))
			node.initialize()
		
	# Call initial state
	currentState = get_node(initialState)
	currentState.enter()
		
# Update every frame
func _process(delta) -> void:
	currentState.update(delta)

# Update physics 
func _physics_process(delta) -> void:
	currentState.update_physics(delta)

# Read input
func _input(event) -> void:
	currentState.handle_input(event)

# Transition to new state. Called by signal state_transitioned.
func on_state_changed(newState: String) -> void:
	# Set newState to uppercase
	newState = newState.to_upper()
	
	# Return if state does not exist or if already in said state
	if !states.has(newState) or currentState == states[newState]:
		return
		
	# Leave current state and enter new state
	currentState.exit()
	currentState = states[newState]
	currentState.enter()
