extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var touchID = -1;
var entities

func _ready():
	set_process_input(true)
	entities = get_parent().get_node("Node2D").get_children()
	pass

func _input(event):
	#if (event.type == InputEvent.SCREEN_TOUCH && event.pressed):
	#	print(event.index);
	#if (event.type == InputEvent.SCREEN_TOUCH && !event.pressed):
	#	touchID = -1;
	if (event.type == InputEvent.SCREEN_DRAG):
		#get_parent().get_node("Node2D").set_pos(event.pos)
		entities[event.index].set_global_pos(event.pos)
