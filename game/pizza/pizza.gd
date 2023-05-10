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



var toppings: Array
var scaleDown: Vector2 = self.scale - Vector2(0.2, 0.2)

var seconds = 0.02


func _ready() -> void:
	$Tween.connect("tween_completed", self, "_tween_done")


func clear_pizza() -> void:
	self.toppings = []

func pulse() -> void:
	_scale_down()
	yield($Tween,"tween_completed")
	_scale_up()


func _scale_down() -> void:
	$Tween.interpolate_property(self, "scale", self.scale, scaleDown, seconds, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()


func _scale_up() -> void:
	$Tween.interpolate_property(self, "scale", self.scale, scaleUp, seconds, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()


func _tween_done(object: Object, node_path: NodePath):
	pass

func add_topping(topping: String) -> void:
	print_debug(topping)
	
