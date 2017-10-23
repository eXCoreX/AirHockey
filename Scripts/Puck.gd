extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var counter = 0;

const sv = 350
var velocity = Vector2(sv, 0)
var paddleVelocity = Vector2(0,0)
var maxVelocity = 4203

func _ready():
	set_linear_velocity(velocity)
	set_fixed_process(true)
	pass

func _integrate_forces(state):
	
	if(state.get_contact_count() >= 1):
		var normal = state.get_contact_local_normal(0)
		#velocity = get_linear_velocity()
		if(normal.dot(velocity.normalized()) < 0):
			velocity = normal.reflect(velocity).normalized() * sv
			paddleVelocity = normal.reflect(paddleVelocity)
		#var adder = Vector2(0, 0);
		if(state.get_contact_collider_object(0).has_method("get_linear_velocity")):
			#adder = state.get_contact_collider_object(0).get_linear_velocity()*0.5
			paddleVelocity = (state.get_contact_collider_object(0).get_linear_velocity())*0.175
			var material = state.get_contact_collider_object(0).get_node("PuckTextures").get_material()
			material.set_shader_param("flash", 1)
			get_node("Tween").interpolate_callback(material, 0.1, "set_shader_param", "flash", 0)
			get_node("Tween").start()
		print(paddleVelocity.length())
		var newVelocity = velocity+paddleVelocity;
		newVelocity = min(newVelocity.length(), maxVelocity) * newVelocity.normalized()
		set_linear_velocity(newVelocity)
	
	pass

func _fixed_process(delta):
	
	velocity = get_linear_velocity()
	get_node("Label").set_text(str(velocity))
	#print(velocity)
	
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