tool
extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export(int, "Blue", "Red") var puck_Texture = 1

var grabbed = false
#onready var prevposition = get_global_pos()
onready var position = get_global_pos()
#var velocity = Vector2(0, 0)
#var prevvelocity = velocity

func _ready():
	set_mode(MODE_STATIC);
	if(puck_Texture == 0):
		get_node("PuckTextures/RedPuck").hide()
		get_node("PuckTextures/BluePuck").show()
	else:
		get_node("PuckTextures/RedPuck").show()
		get_node("PuckTextures/BluePuck").hide()
	set_fixed_process(true)
	pass

func setGrabbed(grab):
	grabbed = grab;
	if(grabbed):
		set_mode(MODE_KINEMATIC);
	else:
		set_mode(MODE_STATIC);
	#	velocity = Vector2(0, 0);
	pass

func moveTo(pos):
	#prevposition = position
	#position = pos
	#prevvelocity = velocity
	#velocity = position - prevposition
	position = pos
	#set_linear_velocity(Vector2(0,0))
	#print(get_global_pos())
	pass

func _fixed_process(delta):
	if(grabbed):
		set_global_pos(position)
		set_linear_velocity(Vector2(0,0))
	get_node("Label").set_text(str(get_linear_velocity()))
	#moveTo(position+velocity*delta)
	#moveTo(get_pos())
	#var vs = Vector2(sign(velocity.x),sign(velocity.y))
	#velocity -= velocity*delta;
	#if(velocity.length_squared() < 1 || vs != Vector2(sign(velocity.x),sign(velocity.y))):
	#	velocity = Vector2(0, 0);
	#	set_process(false);
	#pass