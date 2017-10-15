extends Control

var touchID = -1;
var entities
onready var rect = get_rect()
export(NodePath) var puck

func _ready():
	set_process_input(true)
	entities = get_parent().get_node("Node2D").get_children()
	#print(get_rect())
	pass

func clampS(pos, radius, minimum, maximum):
	if(pos - radius < minimum):
		pos = minimum + radius
	if(pos + radius > maximum):
		pos = maximum - radius
	return pos
	pass

func _input(event):
	var dragged = false
	var isvalid = false
	if (event.type == InputEvent.SCREEN_TOUCH && event.pressed && touchID == -1 && rect.has_point(event.pos)):
		touchID = event.index
		get_node(puck).setGrabbed(true);
		entities[touchID].set_global_pos(event.pos)
		get_node(puck).moveTo(event.pos)
	
	if (event.type == InputEvent.SCREEN_TOUCH && !event.pressed && event.index == touchID):
		touchID = -1;
		get_node(puck).setGrabbed(false);
		
	if (event.type == InputEvent.SCREEN_DRAG && event.index == touchID):
		dragged = true
		get_node(puck).setGrabbed(true);
		var fpos = event.pos
		#print(rect.end)
		fpos.x = clampS(fpos.x, 96, rect.pos.x, rect.end.x)
		fpos.y = clampS(fpos.y, 96, rect.pos.y, rect.end.y)
		entities[touchID].set_global_pos(fpos)
		get_node(puck).moveTo(fpos)
	
	if(!dragged  and get_node(puck).grabbed):
		get_node(puck).setGrabbed(false);
		print("reset")
