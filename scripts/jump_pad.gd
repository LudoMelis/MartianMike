extends Area2D

@onready var sprite = $AnimatedSprite2D
@export var jumpForce = 300

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body is Player:
		sprite.play("jump")
		body.jump(jumpForce)

