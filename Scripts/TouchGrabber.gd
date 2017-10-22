extends Control

var touchID = -1;
var entities
onready var camera = get_node("../Camera2D")
onready var rect = get_rect()
export(NodePath) var puck

func _ready():
	set_process_input(true)
	entities = get_parent().get_node("Node2D").get_children()
	#print(get_rect())
	pass

func clampS(pos, radius, minimum, maximum):
	if(pos.x - radius < minimum.x):
		pos.x = minimum.x + radius
	if(pos.x + radius > maximum.x):
		pos.x = maximum.x - radius
		
	if(pos.y - radius < minimum.y):
		pos.y = minimum.y + radius
	if(pos.y + radius > maximum.y):
		pos.y = maximum.y - radius
	return pos
	pass

func _input(event):
	#var viewport = get_viewport_rect()
	#var correction = get_viewport_transform().get_origin()
	#print(correction)
	#event = make_input_local(event)
	event = make_input_local(event)
	#var transform = camera.get_transform().xform_inv(event.pos) + Vector2(640, 360)
	var transform = get_transform().xform(event.pos)
	var fpos
	#print(transform)
	#entities[9].set_global_pos(transform)
	if (event.type == InputEvent.SCREEN_TOUCH && event.pressed && touchID == -1 && rect.has_point(transform)):# && rect.has_point(event.pos-correction)):
		#print(event.pos-correction)
		touchID = event.index
		get_node(puck).setGrabbed(true);
		fpos = transform
		fpos = clampS(fpos, 96, rect.pos, rect.end)
		entities[touchID].set_global_pos(fpos)
		get_node(puck).moveTo(fpos)
	
	if (event.type == InputEvent.SCREEN_TOUCH && !event.pressed && event.index == touchID):
		touchID = -1;
		get_node(puck).setGrabbed(false);
		
	if (event.type == InputEvent.SCREEN_DRAG && event.index == touchID):
		get_node(puck).setGrabbed(true);
		fpos = transform
		#print(rect.end)
		fpos = clampS(fpos, 96, rect.pos, rect.end)
		#entities[touchID].set_global_pos(fpos)
		#get_node(puck).moveTo(fpos)
		entities[touchID].set_global_pos(fpos)
		get_node(puck).moveTo(fpos)
