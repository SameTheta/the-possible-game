extends Node2D

@export var coinScene: PackedScene

var totalScore = 0
var screen_size

@onready var playerId = $PlayerNode
@onready var enemyId = $EnemyNode
@onready var coinId = $Coin

signal killPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): 
	pass

#spawns new coins when called
func spawnNewCoin():
	var coin = coinScene.instantiate()
	var coinSpawnLocation = Vector2(randf_range(0, screen_size.x), randf_range(0, screen_size.y))
	coin.position = coinSpawnLocation
	
	coinId = coin
	add_child(coin)

# checks which body touched the player
func playerTouchedCoin(area):
	if area == coinId: #if body is coin then spawn a new one and add 1 score
		spawnNewCoin()
		totalScore += 1
		$HUD.update_score(totalScore)

func game_over():
	$HUD.show_game_over()
	$EnemyNode.hide()
	coinId.queue_free()

func new_game():
	totalScore = 0
	$PlayerNode.start($PlayerStartPos.position)
	$EnemyNode.start($EnemyStartPos.position)
	
	$HUD.update_score(totalScore)
	
	spawnNewCoin()
