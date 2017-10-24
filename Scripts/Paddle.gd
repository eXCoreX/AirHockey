tool
extends RigidBody2D

export(int, "Blue", "Red") var puck_Texture = 1 #which puck texture to use 

var grabbed = false #is grabbed
var newpos = Vector2(0, 0) #where to move to
onready var paddlePolygon = get_node("PaddlePolygon") #Find paddle polygon

func get_paddle_material():
	return paddlePolygon.get_material();

func _ready():
	set_mode(MODE_STATIC); # set mode to static
	set_fixed_process(true) # set fixed process
	
	#Find correct texture path
	var texture = "res://Assets/cicker" + ("blue" if puck_Texture == 0 else "red") + ".png";
	
	paddlePolygon.set_texture(load(texture)) #Set texture
	paddlePolygon.set_material(paddlePolygon.get_material().duplicate()) #Create unique material instance
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
	