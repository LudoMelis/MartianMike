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
	
	if Input.is_action_just_pressed("Jump"):
		velocity.y = -jumpForce
	
	velocity.x = direction * speed
	move_and_slide()
