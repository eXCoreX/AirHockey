tool
extends RigidBody2D

export(int, "Blue", "Red") var puck_Texture = 1 #which puck texture to use 

var grabbed = false #is grabbed
var newpos = Vector2(0, 0) #where to move to
onready var paddleTextures = get_node("PaddleTextures") #reference to paddle textures

func get_paddle_material():
	return paddleTextures.get_material();

func _ready():
	set_mode(MODE_STATIC); # set mode to static
	set_fixed_process(true) # set fixed process
	
	#set puck texture
	if(puck_Texture == 0):
		paddleTextures.get_child(0).show()
		paddleTextures.get_child(1).hide()
	else:
		paddleTextures.get_child(0).hide()
		paddleTextures.get_child(1).show()
	
	paddleTextures.set_material(paddleTextures.get_material().duplicate()) #create unique instance of material
	pass

func setGrabbed(grab):
	grabbed = grab;
	if(grabbed):
		set_mode(MODE_KINEMATIC);
	else:
		set_mode(MODE_STATIC);
	pass

func moveTo(pos):
	newpos = pos
	pass

func _fixed_process(delta):
	if(grabbed):
		set_linear_velocity((newpos-get_pos())/delta) #calculate velocity
		set_pos(newpos) #move to new position
	get_node("Label").set_text(str(get_linear_velocity())) #debug text
	