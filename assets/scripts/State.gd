# General purpose class where all the main logic can be written per frame.

extends Node
class_name State

signal state_transitioned(newState: String)

@export var fsm: StateMachine

func enter() -> void:
	pass
	
func exit() -> void:
	pass
	
func initialize() -> void:
	pass

func update(delta) -> void:
	pass

func update_physics(delta) -> void:
	pass

func handle_input(event) -> void:
	pass
