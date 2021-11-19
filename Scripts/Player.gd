extends KinematicBody


export var SPEED = 500

func _ready():
	pass

func _process(delta):
	var direction: Vector2 = Vector2.ZERO
	direction.x = int(Input.is_action_pressed("Right"))-int(Input.is_action_pressed("Left"))
	direction.y = int(Input.is_action_pressed("Forward"))-int(Input.is_action_pressed("Backward"))
	
	var move: Vector2 = -direction*delta*SPEED
	move_and_slide(Vector3(move.y,0,move.x))
