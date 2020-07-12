extends StaticBody2D

signal AteCherry

var SNAKEBODYSCENE = preload("res://scenes/SnakeBody.tscn")
var EXPLOSIONSCENE = preload("res://scenes/Explosion.tscn")

var Direction
var PreviousDirection
var DirectionChanges = Array()

onready var FreeCast = $FreeCast
onready var CherrySensor = $CherrySensor

export(NodePath) var BodiesPath
onready var SnakeBodies = get_node(BodiesPath)
export(NodePath) var ExplosionPath
onready var Explosions = get_node(ExplosionPath)

var MouthOpen = false

func _ready():
	Direction = Global.DirRight
	PreviousDirection = Direction
	$Sprite.modulate = Global.SnakeColor

func _input(event):
	if not Global.Exploded:
		if event.is_action_pressed("ui_up"):
			DirectionChanges.append(Global.DirUp)
		elif event.is_action_pressed("ui_down"):
			DirectionChanges.append(Global.DirDown)
		elif event.is_action_pressed("ui_left"):
			DirectionChanges.append(Global.DirLeft)
		elif event.is_action_pressed("ui_right"):
			DirectionChanges.append(Global.DirRight)

func _process(delta):
	if not Global.Exploded and Global.Update:
		if CherrySensor.get_overlapping_bodies().size() > 0:
			Global.SnakeLength += 1
			$Pickup.play()
			emit_signal("AteCherry")
		
		ChangeDirection()
		
		if CheckFree():
			var pos = get_position()
			SpawnSnakeBody(pos)
			pos += Direction * 8
			set_position(pos)
			PreviousDirection = Direction
			$Move.play()
		else:
			Explode()
		
		MouthOpen = not MouthOpen
		SetSprite()

func ChangeDirection():
	if DirectionChanges.size() > 0:
		var newDir = DirectionChanges[0]
		DirectionChanges.remove(0)
		if Direction == Global.DirLeft or Direction == Global.DirRight:
			if newDir == Global.DirUp:
				Direction = Global.DirUp
			elif newDir == Global.DirDown:
				Direction = Global.DirDown
		else:
			if newDir == Global.DirLeft:
				Direction = Global.DirLeft
			elif newDir == Global.DirRight:
				Direction = Global.DirRight
		if not CheckFree():
			Explode()

func SpawnSnakeBody(pos):
	var snakeBody = SNAKEBODYSCENE.instance()
	snakeBody.Direction = Direction
	snakeBody.PreviousDirection = PreviousDirection
	snakeBody.Explosions = Explosions
	snakeBody.set_position(pos)
	SnakeBodies.add_child(snakeBody)

func CheckFree():
	match Direction:
		Global.DirUp:
			FreeCast.cast_to = Vector2(0, -8)
		Global.DirDown:
			FreeCast.cast_to = Vector2(0, 8)
		Global.DirLeft:
			FreeCast.cast_to = Vector2(-8, 0)
		Global.DirRight:
			FreeCast.cast_to = Vector2(8, 0)
	FreeCast.force_raycast_update()
	return not FreeCast.is_colliding()

func Explode():
	if not Global.Exploded:
		Global.Exploded = true
		Global.SetSnakeSpeed(60.0)
		var explosion = EXPLOSIONSCENE.instance()
		explosion.set_position(get_position())
		Explosions.add_child(explosion)
		queue_free()

func SetSprite():
	var frame
	match Direction:
		Global.DirUp:
			frame = 3
		Global.DirDown:
			frame = 1
		Global.DirLeft:
			frame = 2
		Global.DirRight:
			frame = 0
	frame *= 2
	if MouthOpen:
		frame += 1
	$Sprite.frame = frame
