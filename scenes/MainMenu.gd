extends Control

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		SceneChanger.EndGame()

func _ready():
	Global.LoadLevel()
	SetLevelButtonsEnabled()
	SetMuteButtonText()

func _on_StartButton_pressed():
	$ButtonPressed.play()
	$LevelSelect.visible = true
	$Main.visible = false

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

func SetMuteButtonText():
	if Global.MuteSound:
		$Main/Buttons/MuteButton/Label.text = """Unmute
Sound"""
	else:
		$Main/Buttons/MuteButton/Label.text = """Mute
Sound"""

func SetLevelButtonsEnabled():
	for i in range(10):
		var level = i + 1
		var button = get_node("LevelSelect/Buttons/Level" + str(level))
		var buttonLabel = get_node("LevelSelect/Buttons/Level" + str(level) + "/Label")
		var disabled = Global.LevelsUnlocked < level
		button.disabled = disabled
		if disabled:
			buttonLabel.add_color_override("font_color", Color(0.6, 0.6, 0.6, 1.0))

func _on_MuteButton_pressed():
	MusicController.ChangeSoundMute(not Global.MuteSound)
	SetMuteButtonText()

func _on_Back_pressed():
	$ButtonPressed.play()
	$LevelSelect.visible = false
	$Main.visible = true

func _on_Level1_pressed():
	$ButtonPressed.play()
	Global.Level = 1
	SceneChanger.ChangeScene("res://scenes/Main.tscn")

func _on_Level2_pressed():
	$ButtonPressed.play()
	Global.Level = 2
	SceneChanger.ChangeScene("res://scenes/Main.tscn")

func _on_Level3_pressed():
	$ButtonPressed.play()
	Global.Level = 3
	SceneChanger.ChangeScene("res://scenes/Main.tscn")

func _on_Level4_pressed():
	$ButtonPressed.play()
	Global.Level = 4
	SceneChanger.ChangeScene("res://scenes/Main.tscn")

func _on_Level5_pressed():
	$ButtonPressed.play()
	Global.Level = 5
	SceneChanger.ChangeScene("res://scenes/Main.tscn")

func _on_Level6_pressed():
	$ButtonPressed.play()
	Global.Level = 6
	SceneChanger.ChangeScene("res://scenes/Main.tscn")

func _on_Level7_pressed():
	$ButtonPressed.play()
	Global.Level = 7
	SceneChanger.ChangeScene("res://scenes/Main.tscn")

func _on_Level8_pressed():
	$ButtonPressed.play()
	Global.Level = 8
	SceneChanger.ChangeScene("res://scenes/Main.tscn")

func _on_Level9_pressed():
	$ButtonPressed.play()
	Global.Level = 9
	SceneChanger.ChangeScene("res://scenes/Main.tscn")

func _on_Level10_pressed():
	$ButtonPressed.play()
	Global.Level = 10
	SceneChanger.ChangeScene("res://scenes/Main.tscn")

func _on_ShaderButton_pressed():
	$ButtonPressed.play()
	GlobalShader.ToggleShader()

func _on_GlowButton_pressed():
	$ButtonPressed.play()
	GlobalShader.ToggleGlow()
