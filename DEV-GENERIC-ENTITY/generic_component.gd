extends Node
class_name GenericComponent

signal test_signal(data: int)

var componentAttribute: int = 25

#TEST: Create a test signal
func _process(delta):
	# Randomly send signals
	randomize()
	if (randi_range(0, 10) == 5):
		emit_signal("test_signal", componentAttribute)
