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

func _ready():
	$UI/Begin/FadeInAnimationPlayer.play("FadeIn")
	$UI/Begin/LevelLabel.text = "Level " + str(Global.Level)
	Global.Exploded = true
	Global.SnakeLength = 0
	GenerateMap()
	$GenerationTimer.start()

func _on_GenerationTimer_timeout():
	PlaceSnake()
	PlaceGhosts()
	PlaceCherry()
	Global.SetSnakeSpeed(0)

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
		Begun = false
		Global.Exploded = true
		Global.SetSnakeSpeed(0)
		SceneChanger.ChangeScene("res://scenes/MainMenu.tscn")
	elif LevelEnd and event is InputEventKey and event.pressed:
		if Won:
			Global.Level += 1
		SceneChanger.ChangeScene("res://scenes/Main.tscn")

func GenerateMap():
	for i in range(4):
		var valid = false
		while not valid:
			var pos = GetRandomCoords()
			if pos.x > 64 and pos.y > 64 and pos.x < 224 and pos.y < 224:
				valid = true
				var blockSizeX = ((randi() % 6) + 1)
				var blockSizeY = ((randi() % 6) + 1)
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
			$SnakeBodies.add_child(snakeBody)

func PlaceCherry():
	$Cherry.set_position(GetFreeSpace())

func PlaceGhosts():
	for i in range(Global.Level + 1):
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
	var pos
	while not validPlace:
		pos = NormalizeCoords(GetRandomCoords())
		validPlace = CheckFree(pos)
		validPlace = validPlace and CheckFree(pos + Vector2(-8, 0))
		validPlace = validPlace and CheckFree(pos + Vector2(8, 0))
		validPlace = validPlace and CheckFree(pos + Vector2(0, -8))
		validPlace = validPlace and CheckFree(pos + Vector2(0, 8))
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
	Global.SetSnakeSpeed(Global.Level * 4)
	$UI/Begin/StartTimer.start()

func _on_StartTimer_timeout():
	Begun = true
	Global.Exploded = false
