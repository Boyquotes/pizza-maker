class_name HUD
extends CanvasLayer

var font: DynamicFont
var font_smaller: DynamicFont

onready var topping_up: Label = $ToppingUp
onready var topping_down: Label = $ToppingDown
onready var topping_right: Label = $ToppingRight
onready var topping_left: Label = $ToppingLeft
onready var bottom: Label = $Bottom

onready var top_back: Label = $TopBack
onready var left_back: Label = $LeftBack
onready var down_back: Label = $DownBack
onready var right_back: Label = $RightBack
onready var bottom_back: Label = $BottomBack
onready var order_number: Label = $OrderNumber

onready var order_list: VBoxContainer = $Order


func _ready() -> void:
	_load_font("res://game/font/c64esque.ttf")
	_set_font()
	turn_item_green(3)

func _load_font(path: String) -> void:
	font = DynamicFont.new()
	font.font_data = load(path)
	font.size = 32
	
	font_smaller = DynamicFont.new()
	font_smaller.font_data = load(path)
	font_smaller.size = 24

func set_max_time_left(time: float) -> void:
	$TextureProgress.max_value = time * 20

func update_time_left_bar(time_left: float) -> void:
	$TextureProgress.value = time_left * 20

func update_labels(shift_down: bool) -> void:
	if shift_down:
		self.topping_up.text = Global.toppings.alt_up.capitalize()
		self.top_back.text = Global.toppings.up.capitalize()
		
		self.topping_down.text = Global.toppings.alt_down.capitalize()
		self.down_back.text = Global.toppings.down.capitalize()
		
		self.topping_left.text = Global.toppings.alt_left.capitalize()
		self.left_back.text = Global.toppings.left.capitalize()
		
		self.topping_right.text = Global.toppings.alt_right.capitalize()
		self.right_back.text = Global.toppings.right.capitalize()
		self.bottom.text = "Cook"
		self.bottom_back.text = "Serve"
	else:
		self.topping_up.text = Global.toppings.up.capitalize()
		self.top_back.text = Global.toppings.alt_up.capitalize()
		
		self.topping_down.text = Global.toppings.down.capitalize()
		self.down_back.text = Global.toppings.alt_down.capitalize()
		
		self.topping_left.text = Global.toppings.left.capitalize()
		self.left_back.text = Global.toppings.alt_left.capitalize()
		
		self.topping_right.text = Global.toppings.right.capitalize()
		self.right_back.text = Global.toppings.alt_right.capitalize()
		
		self.bottom.text = "Serve"
		self.bottom_back.text = "Cook"

func update_cash_labels(daily: float) -> void:
	$LblDailyCash.text = str("$", get_currency(daily))

static func get_currency(number: float) -> float:
	# Place the decimal separator
	var txt_numb = "%.2f" % number

	# Place the thousands separator
	for idx in range(txt_numb.find(".") - 3, 0, -3):
		txt_numb = txt_numb.insert(idx, ",")
	return(txt_numb)



func turn_item_green(child: int) -> void:
	self.order_list.get_child(child).modulate = Color.green

func reset_order_color() -> void:
	for c in self.order_list.get_children():
		c.modulate = Color("ffffff")

func update_order_list(code: Array, order_num: int) -> void:
	#for c in self.order_list.get_children():
	self.order_number.text = str("Order #", order_num)
	for i in code.size():
		self.order_list.get_child(i).visible = code[i]

func _set_font() -> void:
	for node in self.get_children():
		if node is Label:
			node.add_font_override("font", font)
	for node in self.order_list.get_children():
		if node is Label:
			node.add_font_override("font", font_smaller)
