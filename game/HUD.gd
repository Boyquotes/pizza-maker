extends CanvasLayer

var font: DynamicFont

onready var topping_up: Label = $ToppingUp
onready var topping_down: Label = $ToppingDown
onready var topping_right: Label = $ToppingRight
onready var topping_left: Label = $ToppingLeft


func _ready() -> void:
	_load_font("res://game/font/mago1.ttf")
	_set_font()

func _load_font(path: String) -> void:
	font = DynamicFont.new()
	font.font_data = load(path)
	font.size = 12

func update_labels(shift_down: bool) -> void:
	if shift_down:
		self.topping_up.text = Global.toppings.alt_up.capitalize()
		self.topping_down.text = Global.toppings.alt_down.capitalize()
		self.topping_left.text = Global.toppings.alt_left.capitalize()
		self.topping_right.text = Global.toppings.alt_right.capitalize()
	else:
		self.topping_up.text = Global.toppings.up.capitalize()
		self.topping_down.text = Global.toppings.down.capitalize()
		self.topping_left.text = Global.toppings.left.capitalize()
		self.topping_right.text = Global.toppings.right.capitalize()


func _set_font() -> void:
	for node in self.get_children():
		if node is Label:
			node.add_font_override("font", font)
