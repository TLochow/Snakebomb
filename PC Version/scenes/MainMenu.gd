extends Control

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		SceneChanger.EndGame()

func _ready():
	Global.LoadLevel()
	SetLevelButtonsEnabled()
	SetMuteButtonText()
	SetColorSliderValues()
	SetCustomDifficultySliderValues()
	if not Global.LevelMode:
		$Main.visible = false
		$CustomDifficulty.visible = true

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
		$Settings/Main/MuteButton/Label.text = """Unmute
Sound"""
	else:
		$Settings/Main/MuteButton/Label.text = """Mute
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

func _on_Custom_pressed():
	$ButtonPressed.play()
	$LevelSelect.visible = false
	$CustomDifficulty.visible = true

func _on_Level1_pressed():
	$ButtonPressed.play()
	Global.Level = 1
	Global.SetDifficultiesByLevel()
	Global.LevelMode = true
	SceneChanger.ChangeScene("res://scenes/Main.tscn")

func _on_Level2_pressed():
	$ButtonPressed.play()
	Global.Level = 2
	Global.SetDifficultiesByLevel()
	Global.LevelMode = true
	SceneChanger.ChangeScene("res://scenes/Main.tscn")

func _on_Level3_pressed():
	$ButtonPressed.play()
	Global.Level = 3
	Global.SetDifficultiesByLevel()
	Global.LevelMode = true
	SceneChanger.ChangeScene("res://scenes/Main.tscn")

func _on_Level4_pressed():
	$ButtonPressed.play()
	Global.Level = 4
	Global.SetDifficultiesByLevel()
	Global.LevelMode = true
	SceneChanger.ChangeScene("res://scenes/Main.tscn")

func _on_Level5_pressed():
	$ButtonPressed.play()
	Global.Level = 5
	Global.SetDifficultiesByLevel()
	Global.LevelMode = true
	SceneChanger.ChangeScene("res://scenes/Main.tscn")

func _on_Level6_pressed():
	$ButtonPressed.play()
	Global.Level = 6
	Global.SetDifficultiesByLevel()
	Global.LevelMode = true
	SceneChanger.ChangeScene("res://scenes/Main.tscn")

func _on_Level7_pressed():
	$ButtonPressed.play()
	Global.Level = 7
	Global.SetDifficultiesByLevel()
	Global.LevelMode = true
	SceneChanger.ChangeScene("res://scenes/Main.tscn")

func _on_Level8_pressed():
	$ButtonPressed.play()
	Global.Level = 8
	Global.SetDifficultiesByLevel()
	Global.LevelMode = true
	SceneChanger.ChangeScene("res://scenes/Main.tscn")

func _on_Level9_pressed():
	$ButtonPressed.play()
	Global.Level = 9
	Global.SetDifficultiesByLevel()
	Global.LevelMode = true
	SceneChanger.ChangeScene("res://scenes/Main.tscn")

func _on_Level10_pressed():
	$ButtonPressed.play()
	Global.Level = 10
	Global.SetDifficultiesByLevel()
	Global.LevelMode = true
	SceneChanger.ChangeScene("res://scenes/Main.tscn")

func _on_ShaderButton_pressed():
	$ButtonPressed.play()
	GlobalShader.ToggleShader()

func _on_GlowButton_pressed():
	$ButtonPressed.play()
	GlobalShader.ToggleGlow()

func _on_SettingsButton_pressed():
	$ButtonPressed.play()
	$Main.visible = false
	$Settings.visible = true

func _on_ColorsButton_pressed():
	$ButtonPressed.play()
	$Settings/Colors.visible = true
	$Settings/Main.visible = false
	
func _on_ColorBackButton_pressed():
	$ButtonPressed.play()
	$Settings/Colors.visible = false
	$Settings/Main.visible = true

func _on_SettingsBackButton_pressed():
	$ButtonPressed.play()
	Global.SaveColors()
	$Main.visible = true
	$Settings.visible = false

func UpdateColors():
	# Level
	SetLabelColor(get_tree().root)
	$HowTo/Sprites/TileMap.modulate = Global.LevelColor
	
	# Snake
	$Settings/Colors/Snake/Sprite1.modulate = Global.SnakeColor
	$Settings/Colors/Snake/Sprite2.modulate = Global.SnakeColor
	$Settings/Colors/Snake/Sprite3.modulate = Global.SnakeColor
	$Settings/Colors/Snake/Sprite4.modulate = Global.SnakeColor
	$HowTo/Sprites/Sprite2.modulate = Global.SnakeColor
	$HowTo/Sprites/Sprite3.modulate = Global.SnakeColor
	$HowTo/Sprites/Sprite4.modulate = Global.SnakeColor
	$HowTo/Sprites/Sprite5.modulate = Global.SnakeColor
	$HowTo/Sprites/Sprite6.modulate = Global.SnakeColor
	$HowTo/Sprites/Sprite7.modulate = Global.SnakeColor
	$HowTo/Sprites/Sprite8.modulate = Global.SnakeColor
	$HowTo/Sprites/Sprite9.modulate = Global.SnakeColor
	$HowTo/Sprites/Sprite11.modulate = Global.SnakeColor
	$HowTo/Sprites/Sprite12.modulate = Global.SnakeColor
	$HowTo/Sprites/Sprite13.modulate = Global.SnakeColor
	$HowTo/Sprites/Sprite14.modulate = Global.SnakeColor
	$HowTo/Sprites/Sprite15.modulate = Global.SnakeColor
	$HowTo/Sprites/Sprite16.modulate = Global.SnakeColor
	$HowTo/Sprites/Sprite17.modulate = Global.SnakeColor
	$HowTo/Sprites/Sprite18.modulate = Global.SnakeColor
	$HowTo/Sprites/Sprite19.modulate = Global.SnakeColor
	$HowTo/Sprites/Sprite20.modulate = Global.SnakeColor
	$HowTo/Sprites/Sprite21.modulate = Global.SnakeColor
	$HowTo/Sprites/Sprite22.modulate = Global.SnakeColor
	$HowTo/Sprites/Sprite23.modulate = Global.SnakeColor
	
	# Cherry
	$Settings/Colors/Cherry/Sprite1.modulate = Global.CherryColor
	$HowTo/Sprites/Sprite.modulate = Global.CherryColor
	
	# Ghost
	$Settings/Colors/Ghost/Sprite1.modulate = Global.GhostColor
	$HowTo/Sprites/Sprite10.modulate = Global.GhostColor
	$HowTo/Sprites/Sprite24.modulate = Global.GhostColor
	$HowTo/Sprites/Sprite25.modulate = Global.GhostColor
	$HowTo/Sprites/Sprite26.modulate = Global.GhostColor
	$HowTo/Sprites/Sprite27.modulate = Global.GhostColor
	
	# Explosion
	$Settings/Colors/Explosion/Sprite1.modulate = Global.ExplosionColor
	$HowTo/Sprites/Sprite29.modulate = Global.ExplosionColor

func SetLabelColor(node):
	if node is Label:
		node.modulate = Global.LevelColor
	var children = node.get_children()
	for child in children:
		SetLabelColor(child)

func SetColorSliderValues():
	$Settings/Colors/Level/LevelColorSlider.value = Global.LevelColor.h * 255.0
	$Settings/Colors/Snake/SnakeColorSlider.value = Global.SnakeColor.h * 255.0
	$Settings/Colors/Cherry/CherryColorSlider.value = Global.CherryColor.h * 255.0
	$Settings/Colors/Ghost/GhostColorSlider.value = Global.GhostColor.h * 255.0
	$Settings/Colors/Explosion/ExplosionColorSlider.value = Global.ExplosionColor.h * 255.0

func _on_LevelColorSlider_value_changed(value):
	Global.LevelColor = Color.from_hsv(value / 255.0, 1.0, 1.0)
	UpdateColors()

func _on_SnakeColorSlider_value_changed(value):
	Global.SnakeColor = Color.from_hsv(value / 255.0, 1.0, 1.0)
	UpdateColors()

func _on_CherryColorSlider_value_changed(value):
	Global.CherryColor = Color.from_hsv(value / 255.0, 1.0, 1.0)
	UpdateColors()

func _on_GhostColorSlider_value_changed(value):
	Global.GhostColor = Color.from_hsv(value / 255.0, 1.0, 1.0)
	UpdateColors()

func _on_ExplosionColorSlider_value_changed(value):
	Global.ExplosionColor = Color.from_hsv(value / 255.0, 1.0, 1.0)
	UpdateColors()

func _on_DefaultColorsButton_pressed():
	Global.LevelColor = Color(1.0, 0.0, 0.471)
	Global.SnakeColor = Color(0.0, 0.667, 0.043)
	Global.CherryColor = Color(1.0, 0.0, 0.0)
	Global.ExplosionColor = Color(0.933, 0.0, 0.0)
	Global.GhostColor = Color(0.0, 0.882, 1.0)
	SetColorSliderValues()

func SetCustomDifficultySliderValues():
	$CustomDifficulty/LevelSizeSlider.value = Global.LevelSize
	$CustomDifficulty/GhostAmountSlider.value = Global.GhostCount
	$CustomDifficulty/SpeedSlider.value = Global.Speed

func _on_LevelSizeSlider_value_changed(value):
	Global.LevelSize = value
	$CustomDifficulty/LevelSizeSlider/Number.text = str(value)

func _on_GhostAmountSlider_value_changed(value):
	Global.GhostCount = value
	$CustomDifficulty/GhostAmountSlider/Number.text = str(Global.GhostCount)

func _on_SpeedSlider_value_changed(value):
	Global.Speed = value
	$CustomDifficulty/SpeedSlider/Number.text = str(Global.Speed)

func _on_CustomDifficultyBack_pressed():
	$ButtonPressed.play()
	$LevelSelect.visible = true
	$CustomDifficulty.visible = false

func _on_StartCustom_pressed():
	$ButtonPressed.play()
	Global.LevelMode = false
	SceneChanger.ChangeScene("res://scenes/Main.tscn")
