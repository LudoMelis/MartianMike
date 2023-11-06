extends ParallaxBackground

@onready var sprite = $ParallaxLayer/Sprite2D
@export var scrollSpeed = 15
@export var bgTexture: CompressedTexture2D = preload("res://assets/textures/bg/Blue.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.texture = bgTexture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if sprite.region_rect.position >= Vector2(64, 64):
		sprite.region_rect.position = Vector2.ZERO
	sprite.region_rect.position += delta * Vector2(scrollSpeed, scrollSpeed)
