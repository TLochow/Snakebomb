extends Node

var Level = 1

var DirLeft = Vector2(-1, 0)
var DirRight = Vector2(1, 0)
var DirUp = Vector2(0, -1)
var DirDown = Vector2(0, 1)

var SnakeLength
var SnakeSpeed

var Exploded

func SetSnakeSpeed(speed):
	SnakeSpeed = speed
	Engine.set_target_fps(speed)
