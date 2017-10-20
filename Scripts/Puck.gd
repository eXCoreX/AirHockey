extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var counter = 0;

const dv = Vector2(250,0)
var velocity = dv

func _ready():
	set_linear_velocity(dv)
	set_fixed_process(true)
	pass

func _integrate_forces(state):
	
	if(state.get_contact_count() >= 1):
		var normal = state.get_contact_local_normal(0)
		#velocity = get_linear_velocity()
		velocity = normal.reflect(velocity)
		var adder = Vector2(0, 0);
		if(state.get_contact_collider_object(0).has_method("get_linear_velocity")):
			adder = state.get_contact_collider_object(0).get_linear_velocity()*0.5
		set_linear_velocity(velocity+adder)
	
	pass

func _fixed_process(delta):
	
	velocity = get_linear_velocity()
	get_node("Label").set_text(str(velocity))
	
	#counter += 1
	
	#if(is_colliding()):
		#1 + (sqrt(couter) * mult)
	#	velocity = get_collision_normal().reflect(velocity)#*dv.length()*(1 + (sqrt(counter)*0.1))
	#	if("prevvelocity" in get_collider()):
	#		velocity += get_collider().prevvelocity
	#		print(get_collider().prevvelocity)
		#print(.get_name())
		
	
	#move(velocity*delta)
	
	pass