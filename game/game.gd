extends Node2D


var is_shift_held: bool 
onready var pizza: Pizza = get_node("Pizza")


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	self.is_shift_held = Input.is_action_pressed("left_shift")
	$HUD.update_labels(self.is_shift_held)
	
	
func _unhandled_key_input(event: InputEventKey) -> void:
	if event.is_action_pressed("ui_accept"):
		# $Pizza.pulse()
		if self.is_shift_held:
			self.pizza.cook()
		else:
			$AnimationPlayer.play("slide_pizza_out")
			# start timer to get new order and send in blank pizza
		
	if event.is_action_pressed("up_topping"):
		$Pizza.pulse()
		if self.is_shift_held:
			self.pizza.add_topping(Global.toppings.alt_up)
		else:
			self.pizza.add_topping(Global.toppings.up)
	elif event.is_action_pressed("down_topping"):
		$Pizza.pulse()
		if self.is_shift_held:
			self.pizza.add_topping(Global.toppings.alt_down)
		else:
			self.pizza.add_topping(Global.toppings.down)
	elif event.is_action_pressed("left_topping"):
		$Pizza.pulse()
		if self.is_shift_held:
			self.pizza.add_topping(Global.toppings.alt_left)
		else:
			self.pizza.add_topping(Global.toppings.left)
	elif event.is_action_pressed("right_topping"):
		$Pizza.pulse()
		if self.is_shift_held:
			self.pizza.add_topping(Global.toppings.alt_right)
		else:
			self.pizza.add_topping(Global.toppings.right)
		


