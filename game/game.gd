extends Node2D


var is_shift_held: bool 
onready var pizza: Pizza = get_node("Pizza")




func _ready() -> void:
	pass

func _process(delta: float) -> void:
	
	self.is_shift_held = Input.is_action_pressed("left_shift")
		
	$HUD.update_labels(self.is_shift_held)
	
	if Input.is_action_just_pressed("ui_accept"):
		# $Pizza.pulse()
		$AnimationPlayer.play("slide_pizza_out")
		
	if Input.is_action_just_pressed("up_topping"):
		$Pizza.pulse()
		if self.is_shift_held:
			self.pizza.add_topping(Global.toppings.alt_up)
		else:
			self.pizza.add_topping(Global.toppings.up)
	elif Input.is_action_just_pressed("down_topping"):
		$Pizza.pulse()
		if self.is_shift_held:
			self.pizza.add_topping(Global.toppings.alt_down)
		else:
			self.pizza.add_topping(Global.toppings.down)
	elif Input.is_action_just_pressed("left_topping"):
		$Pizza.pulse()
		if self.is_shift_held:
			self.pizza.add_topping(Global.toppings.alt_left)
		else:
			self.pizza.add_topping(Global.toppings.left)
	elif Input.is_action_just_pressed("right_topping"):
		$Pizza.pulse()
		if self.is_shift_held:
			self.pizza.add_topping(Global.toppings.alt_right)
		else:
			self.pizza.add_topping(Global.toppings.right)



