extends Control


onready var btn_play: Button = get_node("Button")


func _ready() -> void:
	self.btn_play.connect("pressed", self, "_on_play_pressed")


func _on_play_pressed() -> void:
	var tween = Tween.new()
	add_child(tween)

	tween.interpolate_property(self, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

	yield(tween, "tween_completed")

	get_tree().change_scene("res://game/game.tscn")
