extends Node2D

var player = null
@onready var start = $Start

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_first_node_in_group("player")
	if player != null:
		player.position = start.getSpawnPos()
	
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
	player.position = start.getSpawnPos()
	player.velocity = Vector2.ZERO
