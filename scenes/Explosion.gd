extends Area2D

func _ready():
	$AnimationPlayer.play("Explosion")

func ExplodeFurther():
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.has_method("Explode"):
			body.Explode()

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
