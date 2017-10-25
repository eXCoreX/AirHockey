extends RigidBody2D

onready var TweenNode = get_node("Tween") #Tween node
onready var SP = get_node("SamplePlayer") #SFX Player
var counter = 0; # counter for hits

const sv = 350 #start velocity
var canPlayS = true
var velocity = Vector2(sv, 0) #current velocity
var maxVelocity = 3000 #Maximum velocity

func _ready():
	set_linear_velocity(velocity) #start velocity
	set_fixed_process(true) #set fixed process
	pass

func canPlayYes():
	canPlayS = true

func _integrate_forces(state):
	if(state.get_contact_count() < 1):
		return
	
	TweenNode.stop(self, "velocity/linear") #stop tweens
	var normal = state.get_contact_local_normal(0) #get collision normal
	var collideObj = state.get_contact_collider_object(0) #get colliding object
	var newVelocity = normal.reflect(velocity) #reflect the velocity
	if(collideObj.has_method("get_linear_velocity")): # if colliding body is rigidBody
		if(canPlayS):
			var id = SP.play("paddle")
			SP.set_volume(id, 0.95)
		var paddleVelocity = collideObj.get_linear_velocity() #get paddle velocity
		var material = collideObj.get_paddle_material() #get paddle material
		material.set_shader_param("flash", 1) #flash
		TweenNode.interpolate_callback(material, 0.1, "set_shader_param", "flash", 0) #stop flash after x seconds
		TweenNode.start() #start tween
		if(paddleVelocity.length() != 0 && newVelocity.dot(paddleVelocity) > 0): #if paddle is moving and at the correct angle 
			newVelocity = newVelocity + paddleVelocity.normalized() * min(paddleVelocity.length() * 0.135, 1000)  # add paddle's velocity to puck's velocity 
		elif(newVelocity.length() == 0): #if puck isn't moving
			newVelocity = paddleVelocity * 0.135
		elif(paddleVelocity.length() == 0): #if paddle isn't moving
			TweenNode.interpolate_property(self, "velocity/linear", newVelocity, 0.85*newVelocity, 2, Tween.TRANS_LINEAR, Tween.EASE_OUT) #slowdown slowly
			TweenNode.start()
	else: #if object is static
		if(canPlayS):
			var id = SP.play("wall")
			SP.set_volume(id, 0.80)
		TweenNode.interpolate_property(self, "velocity/linear", newVelocity, 0.95*newVelocity, 2, Tween.TRANS_SINE, Tween.EASE_OUT) #slowdown
		TweenNode.start()
	canPlayS = false
	TweenNode.interpolate_callback(self, 0.05, "canPlayYes")
	TweenNode.start()	
	newVelocity = min(newVelocity.length(), maxVelocity) * newVelocity.normalized() #clamp velocity
	set_linear_velocity(newVelocity) #force set velocity
	
func _fixed_process(delta):
	velocity = get_linear_velocity() #prepare velocity
	get_node("Label").set_text(str(velocity)) #debug lable
	