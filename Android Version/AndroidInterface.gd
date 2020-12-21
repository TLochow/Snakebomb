extends Control

onready var Game = $ViewportContainer/Game

func _ready():
	SceneChanger.Game = Game

func _on_MenuButton_pressed():
	SceneChanger.ChangeScene("res://scenes/MainMenu.tscn")

func _on_UpButton_pressed():
	SendInput("ui_up")

func _on_DownButton_pressed():
	SendInput("ui_down")

func _on_LeftButton_pressed():
	SendInput("ui_left")

func _on_RightButton_pressed():
	SendInput("ui_right")

func SendInput(event):
	var ev = InputEventAction.new()
	ev.action = event
	ev.pressed = true
	SceneChanger.emit_signal("DoneInput")
	if SceneChanger.Snake:
		SceneChanger.Snake._input(ev)
