extends Node2D
tool
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export(int) var text = 0

func _ready():
	if(get_node("Label") != null):
		get_node("Label").set_text(str(text))
	pass
