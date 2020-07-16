extends Node

var LevelMode = true
var Level = 1
var LevelSize = 1
var GhostCount = 1
var Speed = 1

var DirLeft = Vector2(-1, 0)
var DirRight = Vector2(1, 0)
var DirUp = Vector2(0, -1)
var DirDown = Vector2(0, 1)

var ScreenShake = 0.0

var SnakeLength

var Exploded

var MuteSound = false
var GlowShaderActive = true
var RetroShaderActive = false

var LevelsUnlocked = 1

var LevelColor = Color(1.0, 0.0, 0.471)
var SnakeColor = Color(0.0, 0.667, 0.043)
var CherryColor = Color(1.0, 0.0, 0.0)
var ExplosionColor = Color(0.933, 0.0, 0.0)
var GhostColor = Color(0.0, 0.882, 1.0)

func _ready():
	LoadColors()

func SetDifficultiesByLevel():
	LevelSize = Level
	GhostCount = Level
	Speed = Level

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

func LoadColors():
	LevelColor = Color(1.0, 0.0, 0.471)
	SnakeColor = Color(0.0, 0.667, 0.043)
	CherryColor = Color(1.0, 0.0, 0.0)
	ExplosionColor = Color(0.933, 0.0, 0.0)
	GhostColor = Color(0.0, 0.882, 1.0)
	var config = ConfigFile.new()
	var result = config.load("user://settings.cfg")
	if result == OK:
		LevelColor = config.get_value("colors", "level_color", Color(1.0, 0.0, 0.471))
		SnakeColor = config.get_value("colors", "snake_color", Color(0.0, 0.667, 0.043))
		CherryColor = config.get_value("colors", "cherry_color", Color(1.0, 0.0, 0.0))
		ExplosionColor = config.get_value("colors", "explosion_color", Color(0.933, 0.0, 0.0))
		GhostColor = config.get_value("colors", "ghost_color", Color(0.0, 0.882, 1.0))

func SaveColors():
	var config = ConfigFile.new()
	var result = config.load("user://settings.cfg")
	config.set_value("colors", "level_color", LevelColor)
	config.set_value("colors", "snake_color", SnakeColor)
	config.set_value("colors", "cherry_color", CherryColor)
	config.set_value("colors", "explosion_color", ExplosionColor)
	config.set_value("colors", "ghost_color", GhostColor)
	config.save("user://settings.cfg")
