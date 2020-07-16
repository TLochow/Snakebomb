extends StaticBody2D

var MovingHorizontal
var IncreasingMoveValue

var FirstSprite

onready var FreeCast = $FreeCast

var Exploded = false

func _ready():
	FirstSprite = randi() % 2 == 0
	
	var direction = randi() % 4
	MovingHorizontal = direction % 2 == 0
	IncreasingMoveValue = direction > 1
	
	$Sprite.modulate = Global.GhostColor
	
	SetSprite()

func Update():
	if not Global.Exploded:
		FirstSprite = not FirstSprite
		if CheckFree():
			var pos = get_position()
			if MovingHorizontal:
				if IncreasingMoveValue:
					pos += Vector2(8, 0)
				else:
					pos += Vector2(-8, 0)
			else:
				if IncreasingMoveValue:
					pos += Vector2(0, 8)
				else:
					pos += Vector2(0, -8)
			set_position(pos)
		else:
			IncreasingMoveValue = not IncreasingMoveValue
		SetSprite()

func SetSprite():
	var frame
	if MovingHorizontal:
		if IncreasingMoveValue:
			frame = 0
		else:
			frame = 1
	else:
		if IncreasingMoveValue:
			frame = 2
		else:
			frame = 3
	frame *= 2
	if not FirstSprite:
		frame += 1
	$Sprite.frame = frame

func CheckFree():
	if MovingHorizontal:
		if IncreasingMoveValue:
			FreeCast.cast_to = Vector2(8, 0)
		else:
			FreeCast.cast_to = Vector2(-8, 0)
	else:
		if IncreasingMoveValue:
			FreeCast.cast_to = Vector2(0, 8)
		else:
			FreeCast.cast_to = Vector2(0, -8)
	FreeCast.force_raycast_update()
	return not FreeCast.is_colliding()

func Explode():
	if not Exploded:
		Exploded = true
		queue_free()
