extends Node2D

@onready var player = $Player
@onready var startPosition = $StartPosition

# Called when the node enters the scene tree for the first time.
func _ready():
	player.position = startPosition.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("Reset"):
		get_tree().reload_current_scene()


func _on_deathzone_body_entered(body):
	body.position = $StartPosition.global_position
	body.velocity = Vector2.ZERO
