extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var TweenNode = get_node("Tween")

var counter = 0;

const sv = 250
var velocity = Vector2(sv, 0)
var paddleVelocity = Vector2(0,0)
var newVelocity = Vector2(0,0)
var maxVelocity = 4203

func _ready():
	set_linear_velocity(velocity)
	set_fixed_process(true)
	pass

func _integrate_forces(state):
	if(state.get_contact_count() >= 1):
		var normal = state.get_contact_local_normal(0)
		var newVelocity = normal.reflect(velocity)
		TweenNode.stop(self, "velocity/linear")
		if(state.get_contact_collider_object(0).has_method("get_linear_velocity")):
			var collideObj = state.get_contact_collider_object(0)
			var paddleVelocity = collideObj.get_linear_velocity()
			if(paddleVelocity.length() != 0 && newVelocity.dot(paddleVelocity) > 0):
				newVelocity = newVelocity + paddleVelocity * 0.135
			elif(paddleVelocity.length() == 0):
				TweenNode.interpolate_property(self, "velocity/linear", newVelocity, 0.85*newVelocity, 2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
				TweenNode.start()
		else:
			TweenNode.interpolate_property(self, "velocity/linear", newVelocity, 0.95*newVelocity, 2, Tween.TRANS_SINE, Tween.EASE_OUT)
			TweenNode.start()
		newVelocity = min(newVelocity.length(), maxVelocity) * newVelocity.normalized()
		set_linear_velocity(newVelocity)
	
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