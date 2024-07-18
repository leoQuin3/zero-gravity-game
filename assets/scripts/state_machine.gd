# General purpose class to build finite state machines

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
			states[node.name] = node
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
func _unhandled_input(event) -> void:
	currentState.handle_input(event)

# Transition to new state. Called when a state emits a signal
func on_state_changed(key: String) -> void:
	# Return if state does not exist or if already in said state
	if !states.has(key) or currentState == states[key]:
		return
		
	# Leave current state and enter to new state
	currentState.exit()
	currentState = states[key]
	currentState.enter()
