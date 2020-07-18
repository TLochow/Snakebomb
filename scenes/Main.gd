extends Node2D

var GHOSTSCENE = preload("res://scenes/Ghost.tscn")
var SNAKEBODYSCENE = preload("res://scenes/SnakeBody.tscn")

onready var Explosions = $Explosions
onready var Ghosts = $Ghosts
onready var Map = $TileMap

var Begun = false
var LevelEnd = false
var Won = false

var SpawnableArea = Vector2(272, 272)

var ScreenShakeWait = 0.0
var CameraZoom = 1.0

func _ready():
	if Global.LevelMode and Global.Level > Global.LevelsUnlocked:
		Global.LevelsUnlocked = Global.Level
		Global.SaveLevel()
	Global.ScreenShake = 0.0
	$UI/Begin/FadeInAnimationPlayer.play("FadeIn")
	if Global.LevelMode:
		$UI/Begin/LevelLabel.text = "Level " + str(Global.Level)
	else:
		$UI/Begin/LevelLabel.text = "Custom Game"
	Global.Exploded = true
	Global.SnakeLength = 0
	
	$TileMap.modulate = Global.LevelColor
	$Cherry/Sprite.modulate = Global.CherryColor
	
	var levelSize = 12 + (Global.LevelSize * 2)
	CameraZoom = range_lerp(levelSize, 14.0, 34.0, 0.4375, 1.0)
	$Camera2D.zoom *= CameraZoom
	SpawnableArea *= CameraZoom
	var mapBlockMin = levelSize - 1
	for x in range(36):
		for y in range(36):
			if x > mapBlockMin or y > mapBlockMin:
				Map.set_cell(x, y, 0)
	
	GenerateMap()
	$GenerationTimer.start()

func _on_GenerationTimer_timeout():
	PlaceSnake()
	PlaceGhosts()
	PlaceCherry()

func _process(delta):
	if Begun and Global.Exploded:
		ScreenShakeWait -= delta
		if ScreenShakeWait < 0.0:
			ScreenShakeWait = 0.05
			$Camera2D.offset = Vector2(rand_range(-Global.ScreenShake, Global.ScreenShake), rand_range(-Global.ScreenShake, Global.ScreenShake)) * CameraZoom 
		Global.ScreenShake = max(Global.ScreenShake - delta * 5.0, 0.0)
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
		Begun = false
		Global.Exploded = true
		SceneChanger.ChangeScene("res://scenes/MainMenu.tscn")
	elif LevelEnd and event is InputEventKey and event.pressed:
		if Won and Global.LevelMode:
			Global.Level += 1
			Global.SetDifficultiesByLevel()
		if Global.Level > 10:
			SceneChanger.ChangeScene("res://scenes/End.tscn")
		else:
			SceneChanger.ChangeScene("res://scenes/Main.tscn")

func GenerateMap():
	var numberOfBlocks = ceil(Global.LevelSize / 2.5)
	for i in range(numberOfBlocks):
		var valid = false
		while not valid:
			var pos = GetRandomCoords()
			if pos.x > 64 and pos.y > 64 and pos.x < 224 and pos.y < 224:
				valid = true
				var blockSizeX = ((randi() % int(Global.LevelSize)) + 1)
				var blockSizeY = ((randi() % int(Global.LevelSize)) + 1)
				var coord = Map.world_to_map(pos)
				var minX = coord.x - blockSizeX
				var maxX = coord.x + blockSizeX
				var minY = coord.y - blockSizeY
				var maxY = coord.y + blockSizeY
				for x in range(minX, maxX):
					for y in range(minY, maxY):
						Map.set_cell(x, y, 0)
	Map.update_bitmask_region()
	Map.update_dirty_quadrants()

func PlaceSnake():
	var dir = randi() % 4
	var direction
	match dir:
		0:
			direction = Global.DirUp
		1:
			direction = Global.DirDown
		2:
			direction = Global.DirLeft
		3:
			direction = Global.DirRight
	var valid = false
	while not valid:
		valid = true
		var pos = GetFreeSpace()
		var checkPos = pos
		for i in range(3):
			checkPos += direction * 8
			if not CheckFree(checkPos):
				valid = false
		if valid:
			$Snake.set_position(pos)
			$Snake.Direction = direction
			$Snake.SetSprite()
			var snakeBody = SNAKEBODYSCENE.instance()
			snakeBody.Direction = direction
			snakeBody.PreviousDirection = direction
			snakeBody.set_position(pos - (direction * 8))
			snakeBody.SetSprite()
			$MoveTimer.connect("timeout", snakeBody, "Update")
			$SnakeBodies.add_child(snakeBody)

func PlaceCherry():
	$Cherry.set_position(GetFreeSpace())

func PlaceGhosts():
	for i in range(Global.GhostCount):
		var validPlace = false
		while not validPlace:
			var pos = GetFreeSpace()
			if pos.distance_to($Snake.get_position()) > 50.0:
				validPlace = true
				var ghost = GHOSTSCENE.instance()
				ghost.set_position(pos)
				Ghosts.add_child(ghost)

func GetFreeSpace():
	var validPlace = false
	var tryCount = 0
	var pos
	while not validPlace and tryCount < 10:
		pos = NormalizeCoords(GetRandomCoords())
		validPlace = CheckFree(pos)
		tryCount += 1
	return pos

func GetRandomCoords():
	var x = rand_range(16.0, SpawnableArea.x)
	var y = rand_range(16.0, SpawnableArea.y)
	return NormalizeCoords(Vector2(x, y))

func NormalizeCoords(coords):
	coords = Map.world_to_map(coords)
	return Map.map_to_world(coords) + Vector2(4, 4)

func CheckFree(pos):
	$FreeCast.set_position(pos - Vector2(6, 6))
	$FreeCast.force_raycast_update()
	return not $FreeCast.is_colliding()

func _on_Snake_AteCherry():
	PlaceCherry()

func _on_FadeInAnimationPlayer_animation_finished(anim_name):
	$UI/Begin.visible = false
	$MoveTimer.wait_time = 1.0 / (Global.Speed)
	$MoveTimer.connect("timeout", $Snake, "Update")
	var ghosts = $Ghosts.get_children()
	for ghost in ghosts:
		$MoveTimer.connect("timeout", ghost, "Update")
	$UI/Begin/StartTimer.start()

func _on_StartTimer_timeout():
	Begun = true
	Global.Exploded = false
	$MoveTimer.start()

func _on_Snake_Explode():
	$MoveTimer.stop()
