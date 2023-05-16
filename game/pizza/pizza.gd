class_name Pizza
extends Node2D

signal added_topping


enum TOPPINGS {
	CHEESE,
	PEPPERONI,
	CHICKEN,
	OLIVES,
	PINEAPPLES,
	MUSHROOMS,
}

onready var dough: Sprite = $Dough
#onready var peps: Sprite = $Toppings/Peps

onready var scaleUp: Vector2 = self.scale

onready var cheese_sprite: Sprite = $Toppings/Cheese
onready var peps_sprite: Sprite = $Toppings/Peps
onready var mushrooms_sprite: Sprite = $Toppings/Mushrooms
onready var sauce_sprite: Sprite = $Toppings/Sauce
onready var olives_sprite: Sprite = $Toppings/Olives
onready var pineapples_sprite: Sprite = $Toppings/Pineapples






var pizza_code: Array
var is_cooked: bool 

var toppings: Array
var scaleDown: Vector2 = self.scale - Vector2(0.2, 0.2)

var seconds = 0.02


func _ready() -> void:
	self.pizza_code.resize(7)
	$Tween.connect("tween_completed", self, "_tween_done")

func reset() -> void:
	self.modulate = "ffffff"
	$SteamSprites.visible = false
	self.toppings = []
	self.pizza_code = [0,0,0,0,0,0,0]
	self._hide_toppings()
	self.is_cooked = false
	self.position = Vector2(-280,280)
	
	
	

func _update_code(array_item: int) -> void:
	self.pizza_code[array_item] = 1

func _hide_toppings() -> void:
	for t in $Toppings.get_children():
		t.visible = false

func pulse() -> void:
	_scale_down()
	yield($Tween,"tween_completed")
	_scale_up()

func _get_steam_pos() -> Vector2:
	randomize()
	var center = $Area2D/CollisionShape2D.position + $Area2D.position
	var size = $Area2D/CollisionShape2D.shape.extents
	
	var ranX = (randi() % int(size.x)) - (size.x/2)
	var ranY = (randi() % int(size.y)) - (size.y/2)
	
	return Vector2(ranX,ranY)

func cook() -> void:
	if !self.is_cooked:
		_add_steam()
		self._adding_topping(0)
		self.is_cooked = true
	else:
		self._burn()

func _add_steam() -> void:
	self.modulate = "e5c7c7"
	$SteamSprites.visible = true

func _burn() -> void:
	self.modulate = "604a4a"

func _scale_down() -> void:
	$Tween.interpolate_property(self, "scale", self.scale, scaleDown, seconds, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()


func _scale_up() -> void:
	$Tween.interpolate_property(self, "scale", self.scale, scaleUp, seconds, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()


func _tween_done(object: Object, node_path: NodePath):
	pass




#COOKED = 0
#CHEESE = 1
#PEPPERONI = 2
#sauce = 3
#OLIVES = 4
#PINEAPPLES = 5
#MUSHROOMS = 6


func _adding_topping(topping_code: int) -> void:
	self.pulse()
	_update_code(topping_code)
	_show_sprite(topping_code)
	self.emit_signal("added_topping", topping_code)

func _show_sprite(topping_code: int) -> void:
	match topping_code:
		0:
			pass
		1:
			self.cheese_sprite.visible = true
		2:
			self.peps_sprite.visible = true
		3:
			self.sauce_sprite.visible = true
		4:
			self.olives_sprite.visible = true
		5:
			self.pineapples_sprite.visible = true
		6:
			self.mushrooms_sprite.visible = true

func add_topping(topping: String) -> void:
	print("here")
	if !self.toppings.has(topping):
		match(topping):
			Global.toppings.up: # cheese
				pass
				self._adding_topping(1)
			Global.toppings.down: # trash
				pass
			Global.toppings.left: # pepperoni
				self._adding_topping(2)
				pass
			Global.toppings.right: # olives
				self._adding_topping(4)
				pass
			Global.toppings.alt_up: # pineapple
				self._adding_topping(5)
				pass
			Global.toppings.alt_down: # trash
				pass
			Global.toppings.alt_left: # mushrooms
				self._adding_topping(6)
				pass
			Global.toppings.alt_right: # chicken
				self._adding_topping(3)
				pass

		print_debug(str("adding ", topping))
		self.toppings.append(topping)
		# Set sprite to random rotation
		# Make sprite visible
		
	else:
		print(str("Pizza already has ", topping.capitalize()))
