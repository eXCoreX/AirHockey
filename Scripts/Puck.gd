tool
extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export(int, "Blue", "Red") var puck_Texture = 1

var grabbed = false
onready var prevposition = get_global_pos()
onready var position = get_global_pos()
var velocity = Vector2(0, 0)

func _ready():
	if(puck_Texture == 0):
		get_node("PuckTextures/RedPuck").hide()
		get_node("PuckTextures/BluePuck").show()
	else:
		get_node("PuckTextures/RedPuck").show()
		get_node("PuckTextures/BluePuck").hide()
	pass

func setGrabbed(grab):
	grabbed = grab;
	if(grabbed == false):
		velocity = (position - prevposition)
		var sings = Vector2(sign(velocity.x), sign(velocity.y))
		velocity *= velocity
		velocity *= sings/2
		set_process(true);
	else:
		set_process(false);
		velocity = Vector2(0, 0);
	pass

func moveTo(pos):
	prevposition = position
	position = pos
	move_to(position)
	#print(get_global_pos())
	pass

func _process(delta):
	moveTo(position+velocity*delta)
	#moveTo(get_pos())
	var vs = Vector2(sign(velocity.x),sign(velocity.y))
	velocity -= velocity*delta;
	if(velocity.length_squared() < 1 || vs != Vector2(sign(velocity.x),sign(velocity.y))):
		velocity = Vector2(0, 0);
		set_process(false);
	pass