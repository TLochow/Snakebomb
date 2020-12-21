extends CanvasLayer

func _ready():
	Global.LoadShader()
	$Retro/Shader.get_material().set_shader_param("Active", Global.RetroShaderActive)
	$Glow/Shader.get_material().set_shader_param("Active", Global.GlowShaderActive)

func ToggleShader():
	Global.RetroShaderActive = not Global.RetroShaderActive
	$Retro/Shader.get_material().set_shader_param("Active", Global.RetroShaderActive)
	Global.SaveShader()

func ToggleGlow():
	Global.GlowShaderActive = not Global.GlowShaderActive
	$Glow/Shader.get_material().set_shader_param("Active", Global.GlowShaderActive)
	Global.SaveShader()
