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

func _input(event):
	if (event.type == InputEvent.SCREEN_TOUCH && event.pressed && touchID == -1 && rect.has_point(event.pos)):
		touchID = event.index
		get_node(puck).setGrabbed(true);
	if (event.type == InputEvent.SCREEN_TOUCH && !event.pressed && event.index == touchID):
		touchID = -1;
		get_node(puck).setGrabbed(false);
	if (event.type == InputEvent.SCREEN_DRAG && rect.has_point(event.pos) && event.index == touchID):
		entities[touchID].set_global_pos(event.pos)
		get_node(puck).moveTo(event.pos)
