extends Node2D

func _ready():
	Global.LoadSoundSettings()
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), Global.MuteSound)
	$Music.play()

func ChangeSoundMute(mute):
	Global.MuteSound = mute
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), Global.MuteSound)
	Global.SaveSoundSettings()
