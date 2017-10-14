extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_process(true);
	pass

func _input(event):
	if (event.type == InputEvent.SCREEN_TOUCH):
		get_parent().get_node("Node2D").set_pos(event.pos)
		print(event.pos)

func _process(delta):
	
	pass