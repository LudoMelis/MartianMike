extends Node2D

@onready var player = $Player
@onready var startPosition = $StartPosition

# Called when the node enters the scene tree for the first time.
func _ready():
	player.position = startPosition.global_position
	
	var traps = get_tree().get_nodes_in_group("traps")
	for trap in traps:
		trap.touchedPlayer.connect(_on_traps_touched_player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("Reset"):
		get_tree().reload_current_scene()


func _on_deathzone_body_entered(body):
	resetPlayer()


func _on_traps_touched_player():
	resetPlayer()

func resetPlayer():
	player.position = $StartPosition.global_position
	player.velocity = Vector2.ZERO
