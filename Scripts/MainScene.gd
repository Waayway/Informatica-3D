extends Spatial

onready var timer: Timer = get_node("Timer")
onready var Astroid: Resource = preload("res://Scenes/Astroid.tscn")

func _ready():
	pass

func OnTimerTimeout():
	var AstroidInstance: KinematicBody = Astroid.instance()
	AstroidInstance.transform.origin = Vector3(-100, 0, rand_range(-18,18))
	add_child(AstroidInstance)

func pause():
	var SaveGame = get_node("/root/SaveGame")
	SaveGame.save_game()
	get_node("StoppedGamePopup/Label").text = "Score: "+str(SaveGame.currentScore)+"\nHigh Score: "+str(SaveGame.highScore)
	get_tree().paused = true
	$StoppedGamePopup.show()


func _on_Button_pressed():
	$StoppedGamePopup.hide()
	get_tree().change_scene("res://Scenes/MainScene.tscn")
	get_tree().paused = false
