extends CharacterBody2D

@export var gravity = 400
@export var speed = 125
@export var jumpForce = 200
@onready var animatedSprite = $AnimatedSprite2D

func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > 500:
			velocity.y = 500
	
	var direction = Input.get_axis("Left", "Right")
	if direction != 0:
		animatedSprite.flip_h = direction == -1
	
	if Input.is_action_just_pressed("Jump") && is_on_floor():
		velocity.y = -jumpForce
	
	velocity.x = direction * speed
	move_and_slide()
	updateAnimation(direction)
	
	
func updateAnimation(direction):
	if is_on_floor():
		if direction == 0:
			animatedSprite.play("idle")
		else:
			animatedSprite.play("run")
	else:
		if velocity.y > 0:
			animatedSprite.play("fall")
		else:
			animatedSprite.play("jump")
	
