extends Node2D

@onready var start = $Start
@onready var exit = $Exit
@onready var deathzone = $Deathzone
@onready var uiScene = preload("res://scenes/ui.tscn")
@onready var playerScene = preload("res://scenes/player.tscn")

@export var nextLevel: PackedScene = null
@export var levelTime = 5
var player = null
var timer = null
var hud = null
var timeLeft
var win = false

# Called when the node enters the scene tree for the first time.
func _ready():

	
	var traps = get_tree().get_nodes_in_group("traps")
	for trap in traps:
		trap.touchedPlayer.connect(_on_traps_touched_player)
	exit.body_entered.connect(_on_exit_body_entered)
	deathzone.body_entered.connect(_on_deathzone_body_entered)
	setPlayer()
	setTimer()
	setUi()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("Reset"):
		get_tree().reload_current_scene()
		
func setPlayer():
	player = playerScene.instantiate()
	add_child(player)
#	player = get_tree().get_first_node_in_group("player")
	if player != null:
		player.position = start.getSpawnPos()

func setTimer():
	timeLeft = levelTime
	timer = Timer.new()
	timer.name = "LevelTimer"
	timer.wait_time = 1
	timer.timeout.connect(_on_level_timer_out)
	add_child(timer)
	timer.start()

func setUi():
	var uiInstance = uiScene.instantiate()
	add_child(uiInstance)
	hud = uiInstance.get_node("HUD")
	hud.setTimerLabel(timeLeft)

func _on_level_timer_out():
	if !win:
		timeLeft -= 1
	if timeLeft < 0:
		resetPlayer()
		timeLeft = levelTime
	hud.setTimerLabel(timeLeft)

func _on_deathzone_body_entered(body):
	resetPlayer()


func _on_traps_touched_player():
	resetPlayer()
	
func _on_exit_body_entered(body):
	if body is Player && nextLevel != null:
		win = true
		exit.animate()
		player.active = false
		await get_tree().create_timer(3).timeout
		get_tree().change_scene_to_packed(nextLevel)


func resetPlayer():
	player.position = start.getSpawnPos()
	player.velocity = Vector2.ZERO
