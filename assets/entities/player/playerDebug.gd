extends CanvasLayer

##ADD TO PLAYER AS CHILD

@export var node: Player
@export var InputArrow: Node2D
@export var InputLabel: Label
@export var VelocityArrow: Node2D
@export var VelocityLabel: Label


func _process(delta):
	var inputVector = Input.get_vector("left", "right", "forward", "back")
	InputArrow.rotation = atan2(inputVector.y, inputVector.x)
	InputArrow.scale.x = inputVector.length()
	InputLabel.text = "Input Axis: " + str(inputVector)
	
	VelocityArrow.rotation = atan2(node.velocity.z, node.velocity.x)
	VelocityArrow.scale.x = node.velocity.length() * 0.1
	VelocityLabel.text = str(node.velocity.round()) + "\nvelocity: " + str(roundf(node.velocity.length()))
