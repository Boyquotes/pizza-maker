extends CanvasLayer

var font: DynamicFont

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



func _ready() -> void:
	_load_font("res://game/font/c64esque.ttf")
	_set_font()

func _load_font(path: String) -> void:
	font = DynamicFont.new()
	font.font_data = load(path)
	font.size = 18

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


func _set_font() -> void:
	for node in self.get_children():
		if node is Label:
			node.add_font_override("font", font)
