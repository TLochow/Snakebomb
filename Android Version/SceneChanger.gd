extends CanvasLayer

signal DoneInput

var Game
var Snake

func _init():
	randomize()

func _ready():
	$AnimationPlayer.play("FadeIn")

func ChangeScene(path):
	$AnimationPlayer.play("FadeOut")
	yield($AnimationPlayer, "animation_finished")
	var nextScene = load(path).instance()
	Game.get_children()[0].queue_free()
	Game.add_child(nextScene)
	$AnimationPlayer.play("FadeIn")

func EndGame():
	$AnimationPlayer.play("FadeOut")
	yield($AnimationPlayer, "animation_finished")
	get_tree().quit()
