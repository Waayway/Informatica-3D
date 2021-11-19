extends KinematicBody

export var SPEED: float = 1000

func _ready():
	pass

func _process(delta):
	var speed = delta*SPEED
	move_and_slide(Vector3(-speed,0,0))
