extends Area2D

@export var Speed = 300.0

var screen_size
signal body_touched
signal playerKilled

func _ready():
	hide()
	screen_size = get_viewport_rect().size
	
func start(pos):
	position = pos
	show()
	$hitbox.disabled = false

func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * Speed
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

func _on_area_entered(area):
	body_touched.emit(area)

func killPlayer():
	hide()
	$hitbox.set_deferred("disabled", true)
	playerKilled.emit()
