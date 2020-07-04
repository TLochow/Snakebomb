extends Control

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		SceneChanger.EndGame()

func _on_StartButton_pressed():
	$ButtonPressed.play()
	Global.Level = 1
	SceneChanger.ChangeScene("res://scenes/Main.tscn")

func _on_HowToButton_pressed():
	$ButtonPressed.play()
	$Main.visible = false
	$HowTo.visible = true

func _on_ExitButton_pressed():
	$ButtonPressed.play()
	SceneChanger.EndGame()

func _on_BackButton_pressed():
	$ButtonPressed.play()
	$Main.visible = true
	$HowTo.visible = false
