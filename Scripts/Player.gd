extends KinematicBody


export var SPEED = 500
export var MAXROTSPEED = 2
export var ROTSPEEDUP = 0.2

var curRotation = 0
var curRotSpeed = 0

onready var SpawnBulletPoint: Spatial = get_node("SpawnBullet")
onready var SpaceShipMesh: MeshInstance = get_node("Cube")

onready var Bullet: Resource = load("res://Scenes/Bullet.tscn")

func _ready():
	pass

func _process(delta):
	var direction: Vector2 = Vector2.ZERO
	direction.x = int(Input.is_action_pressed("Right"))-int(Input.is_action_pressed("Left"))
	direction.y = int(Input.is_action_pressed("Forward"))-int(Input.is_action_pressed("Backward"))
	
	var move: Vector2 = -direction*delta*SPEED
	
	if curRotation == 0 && direction.x == 0:
		curRotSpeed = 0.1
	if direction.x == 1:
		curRotation += curRotSpeed
		curRotSpeed += ROTSPEEDUP
	elif direction.x == -1:
		curRotation -= curRotSpeed
		curRotSpeed += ROTSPEEDUP
	else:
		if curRotation < 0:
			curRotation += curRotSpeed
			curRotSpeed += ROTSPEEDUP
		elif curRotation > 0:
			curRotation -= curRotSpeed
			curRotSpeed += ROTSPEEDUP
	
	curRotation = clamp(curRotation,-20,20)
	curRotSpeed = clamp(curRotSpeed,0,MAXROTSPEED)
	
	SpaceShipMesh.rotation.x = deg2rad(-curRotation)
	move_and_slide(Vector3(move.y,0,move.x))
	
	if Input.is_action_just_pressed("Shoot"):
		var BulletInstance: KinematicBody = Bullet.instance()
		BulletInstance.global_transform = SpawnBulletPoint.global_transform
		get_parent().add_child(BulletInstance)
