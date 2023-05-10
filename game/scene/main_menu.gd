extends Control


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var btn_play: Button = get_node("Button")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.btn_play.connect("pressed", self, "_on_play_pressed")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func _on_play_pressed() -> void:
	var tween = Tween.new()
	add_child(tween)

	tween.interpolate_property(self, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

	yield(tween, "tween_completed")

	get_tree().change_scene("res://game/game.tscn")
