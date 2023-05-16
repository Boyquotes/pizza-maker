extends Node2D


var day_of_week: Array = [
	"Mon", "Tues", "Wed", "Thurs", "Fri"
]

var cost_of_dough: float = 2.0

var cash: float
var is_shift_held: bool 
var break_time: float = 2.0
var time_per_round: float = 15.0

var order_pizza_code: Array

#COOKED = 0
#CHEESE = 1
#PEPPERONI = 2
#sauce = 3
#OLIVES = 4
#PINEAPPLES = 5
#MUSHROOMS = 6

var daily_income: float
var daily_tips: float
var daily_expense: float

var order_num: int
var order_items: int = 3
var order_time: float = 10.0


onready var hud: HUD = $HUD
onready var pizza: Pizza = get_node("Pizza")
onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var trm_next_order: Timer = get_node("TrmNextOrder")
onready var trm_order_time: Timer = get_node("TrmOrderTime")



func _ready() -> void:
	self.order_pizza_code.resize(7)
	self.animation_player.connect("animation_finished", self, "_on_animation_done")
	self.trm_next_order.connect("timeout", self, "_start_new_round")
	self.trm_order_time.connect("timeout", self, "_end_round")
	self.pizza.connect("added_topping", self.hud, "turn_item_green")
	self._start_new_game()
	
	print(_get_new_pizza_code(self.order_items))
	print(_get_new_pizza_code(self.order_items))
	print(_get_new_pizza_code(self.order_items))
	print(_get_new_pizza_code(self.order_items))
	print(_get_new_pizza_code(self.order_items))
	print(_get_new_pizza_code(self.order_items))
	
	
func _start_new_game() -> void:
	self.order_num = 0
	self._start_new_round()

func _process(delta: float) -> void:
	self.is_shift_held = Input.is_action_pressed("left_shift")
	$HUD.update_labels(self.is_shift_held)
	self.hud.update_time_left_bar(self.trm_order_time.time_left)
	

func _unhandled_key_input(event: InputEventKey) -> void:
	
	if !self.animation_player.is_playing():
		if event.is_action_pressed("ui_accept"):

			if self.is_shift_held:
				self.pizza.cook()
			else:
				# TODO: Prevent spamming of pressing sapce
				self.animation_player.play("slide_pizza_out")
				# start timer to get new order and send in blank pizza
			
		if event.is_action_pressed("up_topping"):

			if self.is_shift_held:
				self.pizza.add_topping(Global.toppings.alt_up)
			else:
				self.pizza.add_topping(Global.toppings.up)
		elif event.is_action_pressed("down_topping"):
			# Trash pizza
			print("trash the pizza")
#			if self.is_shift_held:
#				self.pizza.add_topping(Global.toppings.alt_down)
#			else:
#				self.pizza.add_topping(Global.toppings.down)
		elif event.is_action_pressed("left_topping"):

			if self.is_shift_held:
				self.pizza.add_topping(Global.toppings.alt_left)
			else:
				self.pizza.add_topping(Global.toppings.left)
		elif event.is_action_pressed("right_topping"):

			if self.is_shift_held:
				self.pizza.add_topping(Global.toppings.alt_right)
			else:
				self.pizza.add_topping(Global.toppings.right)
		

func _start_new_day() -> void:
	pass
	# Advnace day
	# Update day of week on HUD

func _start_new_round() -> void:
	self.hud.reset_order_color()
	self.hud.set_max_time_left(self.order_time)
	self.order_num += 1
	self.pizza.reset()
	self.order_pizza_code = _get_new_pizza_code(self.order_items)
	self.hud.update_order_list(self.order_pizza_code, self.order_num)
	# TODO: change to start_new_order
	self.daily_expense += self.cost_of_dough
	self.animation_player.play("slide_pizza_in")
	

func _trash_pizza() -> void:
	# explode pizza with animation 
	pass
	# Send in new pizza 

func _get_new_pizza_code(order_items: int) -> Array:
	randomize()
	var code: Array = []
	code.resize(7)
	code[0] = randi() & 1
	code[1] = randi() & 1
	code[2] = randi() & 1
	code[3] = randi() & 1
	code[4] = randi() & 1
	code[5] = randi() & 1
	code[6] = randi() & 1
	return code

func _end_round() -> void:
	print("time ran out, customer left")
	self.animation_player.play("trash_pizza")
	# Trash the pizza 

func _check_pizza() -> void:
	print(str("Order was: ", self.order_pizza_code))
	print(str("Player made: ", self.pizza.pizza_code))
	if self.order_pizza_code == self.pizza.pizza_code:
		print("Correct Order")
	else:
		print("Wrong Order")

func _get_new_pizza() -> void:
	self.pizza.reset()
	self.trm_next_order.start(self.break_time)

func _on_animation_done(anim_name: String):
	match anim_name:
		"slide_pizza_in":
			print("new pizza on table")
			self.trm_order_time.start(self.order_time)
			self.trm_order_time.paused = false
		"slide_pizza_out":
			print("pizza has been served")
			self.trm_order_time.paused = true
			# TODO: Check if pizza was right
			self._check_pizza()
			self._get_new_pizza()
			# Reset pizza
		"trash_pizza":
			self._get_new_pizza()

