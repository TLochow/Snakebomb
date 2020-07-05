extends Node

var Update = true

var Level = 1

var DirLeft = Vector2(-1, 0)
var DirRight = Vector2(1, 0)
var DirUp = Vector2(0, -1)
var DirDown = Vector2(0, 1)

var ScreenShake = 0.0

var SnakeLength
var SnakeSpeed
var UpdateDelay

var Exploded

var MuteSound = false
var GlowShaderActive = true
var RetroShaderActive = false

var LevelsUnlocked = 1

func SetSnakeSpeed(speed):
	SnakeSpeed = speed
	UpdateDelay = 60.0 / SnakeSpeed

func LoadSoundSettings():
	MuteSound = false
	var config = ConfigFile.new()
	var result = config.load("user://settings.cfg")
	if result == OK:
		MuteSound = config.get_value("settings", "mute_sound", false)

func SaveSoundSettings():
	var config = ConfigFile.new()
	var result = config.load("user://settings.cfg")
	config.set_value("settings", "mute_sound", MuteSound)
	config.save("user://settings.cfg")

func LoadLevel():
	LevelsUnlocked = 1
	var config = ConfigFile.new()
	var result = config.load("user://settings.cfg")
	if result == OK:
		LevelsUnlocked = config.get_value("save", "levels_unlocked", 1)

func SaveLevel():
	var config = ConfigFile.new()
	var result = config.load("user://settings.cfg")
	config.set_value("save", "levels_unlocked", LevelsUnlocked)
	config.save("user://settings.cfg")

func LoadShader():
	GlowShaderActive = true
	RetroShaderActive = false
	var config = ConfigFile.new()
	var result = config.load("user://settings.cfg")
	if result == OK:
		GlowShaderActive = config.get_value("settings", "glow_shader_active", true)
		RetroShaderActive = config.get_value("settings", "retro_shader_active", false)

func SaveShader():
	var config = ConfigFile.new()
	var result = config.load("user://settings.cfg")
	config.set_value("settings", "glow_shader_active", GlowShaderActive)
	config.set_value("settings", "retro_shader_active", RetroShaderActive)
	config.save("user://settings.cfg")
