extends Spatial

onready var StoppedGame: Popup = get_node("Control/StoppedGamePopup")
var Astroid: Resource = preload("res://Scenes/Astroid.tscn")


func _ready():
	var AstroidInstance: KinematicBody = Astroid.instance()
	AstroidInstance.transform.origin = Vector3(-100, 0, rand_range(-18,18))
	AstroidInstance.rotation_degrees = Vector3(rand_range(-180,180),rand_range(-180,180),rand_range(-180,180))
	add_child(AstroidInstance)
	
	var window_size :Vector2 = OS.get_real_window_size()
	var vbox: VBoxContainer = get_node("Control/StoppedGamePopup/VBoxContainer")
	
	vbox.margin_left = window_size.x/4
	vbox.margin_right = (window_size.x/4)*3
	
	vbox.margin_top = window_size.y/4
	vbox.margin_bottom = (window_size.y/4)*3
	

func OnTimerTimeout():
	var AstroidInstance: KinematicBody = Astroid.instance()
	AstroidInstance.transform.origin = Vector3(-100, 0, rand_range(-18,18))
	AstroidInstance.rotation_degrees = Vector3(rand_range(-180,180),rand_range(-180,180),rand_range(-180,180))
	add_child(AstroidInstance)

func pause():
	var SaveGame = get_node("/root/SaveGame")
	SaveGame.save_game()
	get_node("Control/StoppedGamePopup/VBoxContainer/Label").text = "Score: "+str(SaveGame.currentScore)+"\nHigh Score: "+str(SaveGame.highScore)
	get_tree().paused = true
	StoppedGame.show()


func _on_Button_pressed():
	StoppedGame.hide()
	get_tree().change_scene("res://Scenes/MainScene.tscn")
	get_tree().paused = false
