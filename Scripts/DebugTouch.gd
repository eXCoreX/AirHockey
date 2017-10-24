tool
extends Node2D

export(int) var text = 0

func _ready():
	if(get_node("Label") != null):
		get_node("Label").set_text(str(text))
	pass
