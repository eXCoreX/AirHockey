extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var counter = 0;

const dv = Vector2(250,0)
var velocity = dv

func _ready():
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	
	counter += 1
	
	if(is_colliding()):
		#1 + (sqrt(couter) * mult)
		velocity = get_collision_normal().reflect(velocity)#*dv.length()*(1 + (sqrt(counter)*0.1))
		if("prevvelocity" in get_collider()):
			velocity += get_collider().prevvelocity
			print(get_collider().prevvelocity)
		#print(.get_name())
		
	
	move(velocity*delta)
	
	pass