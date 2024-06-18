extends RigidBody2D

@export var SPEED = 200
var playerBody = null

signal hitPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

func start(pos):
	position = pos
	show()
	$hitbox.disabled = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var velocity = Vector2.ZERO
	if playerBody:
		velocity = global_position.direction_to(playerBody.global_position) * SPEED
		
		position += velocity * delta
	

func _on_player_collision_entered(area):
	if area != $PlayerDetection:
		hitPlayer.emit()
		playerBody = null

func _on_player_detection_area_entered(area):
	if area != $PlayerCollision:
		print("Player has been detected")
		playerBody = area

func _on_player_detection_area_exited(area):
	if area != $PlayerCollision:
		playerBody = null
