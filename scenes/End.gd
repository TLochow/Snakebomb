extends Control

func _input(event):
	if (event is InputEventKey and event.pressed) or event.is_action_pressed("mouse_click"):
		SceneChanger.ChangeScene("res://scenes/MainMenu.tscn")
