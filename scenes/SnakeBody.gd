extends StaticBody2D

var EXPLOSIONSCENE = preload("res://scenes/Explosion.tscn")

var Life
var PreviousDirection = Vector2(1, 0)
var Direction = Vector2(1, 0)

var Exploded = false

var Explosions

func _ready():
	Life = 0
	SetSprite()

func _process(delta):
	if not Global.Exploded and Global.Update:
		Life += 1
		SetSprite()
		if Life > Global.SnakeLength:
			queue_free()

func SetSprite():
	var spriteFrame = 22
	if Life == Global.SnakeLength:
		match Direction:
			Global.DirUp:
				spriteFrame = 19
			Global.DirDown:
				spriteFrame = 17
			Global.DirLeft:
				spriteFrame = 18
			Global.DirRight:
				spriteFrame = 16
	else:
		match Direction:
			Global.DirUp:
				match PreviousDirection:
					Global.DirUp:
						spriteFrame = 9
					Global.DirLeft:
						spriteFrame = 11
					Global.DirRight:
						spriteFrame = 10
			Global.DirDown:
				match PreviousDirection:
					Global.DirDown:
						spriteFrame = 9
					Global.DirLeft:
						spriteFrame = 12
					Global.DirRight:
						spriteFrame = 13
			Global.DirLeft:
				match PreviousDirection:
					Global.DirLeft:
						spriteFrame = 8
					Global.DirUp:
						spriteFrame = 13
					Global.DirDown:
						spriteFrame = 10
			Global.DirRight:
				match PreviousDirection:
					Global.DirRight:
						spriteFrame = 8
					Global.DirUp:
						spriteFrame = 12
					Global.DirDown:
						spriteFrame = 11
	$Sprite.frame = spriteFrame

func Explode():
	if not Exploded:
		Exploded = true
		var explosion = EXPLOSIONSCENE.instance()
		explosion.set_position(get_position())
		Explosions.add_child(explosion)
		queue_free()
