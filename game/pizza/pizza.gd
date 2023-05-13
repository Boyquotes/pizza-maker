class_name Pizza
extends Node2D



enum TOPPINGS {
	CHEESE,
	PEPS,
	CHICKEN,
	OLIVES,
	PINEAPPLE,
	
}

onready var dough: Sprite = $Dough
onready var peps: Sprite = $Peps

onready var scaleUp: Vector2 = self.scale

var is_cooked: bool 

var toppings: Array
var scaleDown: Vector2 = self.scale - Vector2(0.2, 0.2)

var seconds = 0.02


func _ready() -> void:
	$Tween.connect("tween_completed", self, "_tween_done")

func reset() -> void:
	self.modulate = "ffffff"
	$SteamSprites.visible = false
	self.toppings = []
	self.is_cooked = false
	self.position = Vector2(-98,138)
	



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

func add_topping(topping: String) -> void:
	if !self.toppings.has(topping):
		match(topping):
			Global.toppings.up: # ex cheese
				pass
			Global.toppings.down: # chicken
				pass
			Global.toppings.left: # pepperoni
				pass
			Global.toppings.right: # olives
				pass
			Global.toppings.alt_up: # pineapple
				pass
			Global.toppings.alt_down: # mushroom
				pass
			Global.toppings.alt_left: # g peppers
				pass
			Global.toppings.alt_right: # onion
				pass

		print_debug(str("adding ", topping))
		self.toppings.append(topping)
		# Set sprite to random rotation
		# Make sprite visible
		
	else:
		print(str("Pizza already has ", topping.capitalize()))
