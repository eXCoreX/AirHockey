extends Control

var touchID = -1; #id of the touch
var entities #debug touch entities
onready var rect = get_rect() #rect of the touch grabber
export(NodePath) var paddlePath #path to paddle
var paddle #paddle node

func _ready():
	set_process_input(true)
	entities = get_parent().get_node("debugtouch").get_children() #get debug touch entities
	paddle = get_node(paddlePath) #set paddle from paddlePath
	pass

func clampCircleToRect(pos, radius, rect): #Clamp circle pos to rect
	if(pos.x - radius < rect.pos.x):
		pos.x = rect.pos.x + radius
	if(pos.x + radius > rect.end.x):
		pos.x = rect.end.x - radius
		
	if(pos.y - radius < rect.pos.y):
		pos.y = rect.pos.y + radius
	if(pos.y + radius > rect.end.y):
		pos.y = rect.end.y - radius
	return pos
	pass

func _input(event):
	
	if(!(event.type == InputEvent.SCREEN_TOUCH || event.type == InputEvent.SCREEN_DRAG)):
		return #if event is wrong then stop the function
	
	event = make_input_local(event) #make events pos local
	var globalPos = get_transform().xform(event.pos) #make event pos global

	if (event.type == InputEvent.SCREEN_TOUCH && event.pressed && touchID == -1 && rect.has_point(globalPos)):
		#if no finger is touching inside the grabber
		touchID = event.index #record index of the touch
		paddle.setGrabbed(true); #set puck to grabbed
		globalPos = clampCircleToRect(globalPos, 96, rect) #clamp to rect of grabber
		entities[touchID].set_global_pos(globalPos) #debug touch markers
		paddle.moveTo(globalPos) #move the puck
		return
	
	if (event.type == InputEvent.SCREEN_TOUCH && !event.pressed && event.index == touchID):
		#if the controlling finger stopped touching
		touchID = -1; #set touch id to none
		paddle.setGrabbed(false); #set puck to not grabbed
		return
		
	if (event.type == InputEvent.SCREEN_DRAG && event.index == touchID):
		#if controlling finger drags
		paddle.setGrabbed(true); #set puck to grabbed
		globalPos = clampCircleToRect(globalPos, 96, rect) #clamp to rect
		entities[touchID].set_global_pos(globalPos) #debug markers
		paddle.moveTo(globalPos) #move puck
		return
