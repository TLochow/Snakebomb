extends Node2D

var GHOSTSCENE = preload("res://scenes/Ghost.tscn")

onready var FreeCast = $FreeCast
onready var Explosions = $Explosions
onready var Ghosts = $Ghosts

var Begun = false
var LevelEnd = false
var Won = false

var ProjectResolution
var PlayField

func _ready():
	ProjectResolution = Vector2(ProjectSettings.get_setting("display/window/size/width"), ProjectSettings.get_setting("display/window/size/height"))
	PlayField = ProjectResolution / 8
	$UI/Begin/LevelLabel.text = "Level " + str(Global.Level)
	Global.Exploded = true
	Global.SnakeLength = 2
	PlaceCherry()
	PlaceGhosts()
	Global.SetSnakeSpeed(0)
	$UI/Begin/FadeInAnimationPlayer.play("FadeIn")

func _process(delta):
	if Global.Exploded and Begun:
		if Explosions.get_child_count() == 0:
			if not LevelEnd:
				LevelEnd = true
				$UI/End.visible = true
				if Ghosts.get_child_count() > 0:
					Won = false
					$UI/End/Loose.visible = true
				else:
					Won = true
					$UI/End/Win.visible = true

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		SceneChanger.EndGame()
	elif LevelEnd and event is InputEventKey and event.pressed:
		if Won:
			Global.Level += 1
		else:
			Global.Level = 1
		SceneChanger.ChangeScene("res://scenes/Main.tscn")

func PlaceCherry():
	var validPlace = false
	while not validPlace:
		var x = (randi() % int(PlayField.x - 2)) + 2
		var y = (randi() % int(PlayField.y - 2)) + 2
		var pos = Vector2(x * 8, y * 8)
		if CheckFree(pos):
			$Cherry.set_position(pos)
			validPlace = true

func PlaceGhosts():
	for i in range(Global.Level + 1):
		var validPlace = false
		while not validPlace:
			var x = (randi() % int(PlayField.x - 2)) + 2
			var y = (randi() % int(PlayField.y - 2)) + 2
			var pos = Vector2(x * 8, y * 8)
			if CheckFree(pos):
				if pos.distance_to($Snake.get_position()) > 50.0:
					validPlace = true
					var ghost = GHOSTSCENE.instance()
					ghost.set_position(pos)
					Ghosts.add_child(ghost)

func CheckFree(pos):
	FreeCast.set_position(pos)
	FreeCast.cast_to = pos + Vector2(1, 1)
	FreeCast.force_raycast_update()
	return not FreeCast.is_colliding()

func _on_Snake_AteCherry():
	PlaceCherry()

func _on_FadeInAnimationPlayer_animation_finished(anim_name):
	Global.Exploded = false
	$UI/Begin.visible = false
	Begun = true
	Global.SetSnakeSpeed(10 + Global.Level)
