extends CharacterBody2D

@onready var animatedSprite = $AnimatedSprite2D

func _process(delta):
	# For testing purpose :
	if Input.is_action_just_pressed("Right"):
		animatedSprite.play("run")
