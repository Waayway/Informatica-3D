extends Spatial

onready var timer: Timer = get_node("Timer")
onready var Astroid: Resource = load("res://Scenes/Astroid.tscn")

func _ready():
	pass

func OnTimerTimeout():
	var AstroidInstance: KinematicBody = Astroid.instance()
	AstroidInstance.transform.origin = Vector3(-100, 0, rand_range(-18,18))
	add_child(AstroidInstance)

func pause():
	get_tree().paused = true
	$StoppedGamePopup.show()


func _on_Button_pressed():
	$StoppedGamePopup.hide()
	get_tree().change_scene("res://Scenes/MainScene.tscn")
	get_tree().paused = false
