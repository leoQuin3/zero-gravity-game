extends CanvasLayer

@export var node: CharacterBody3D
@export var InputArrow: Node2D
@export var InputLabel: Label
@export var VelocityArrow: Node2D
@export var VelocityLabel: Label

# Visualize controller input and player movement
func _process(delta):
	var inputVector = Input.get_vector("left", "right", "forward", "back")
	InputArrow.rotation = atan2(inputVector.y, inputVector.x)
	InputArrow.scale.x = inputVector.length()
	InputLabel.text = "Input Axis: " + str(inputVector)
	
	VelocityArrow.rotation = atan2(node.velocity.z, node.velocity.x)
	VelocityArrow.scale.x = node.velocity.length() * 0.1
	VelocityLabel.text = str(node.velocity.round()) + "\nvelocity: " + str(roundf(node.velocity.length()))
