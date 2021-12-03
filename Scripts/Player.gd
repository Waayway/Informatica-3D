extends KinematicBody

export var SPEED = 1000
export var ROTSPEED = 5

onready var SpawnBulletPoint: Spatial = get_node("SpawnBullet")
onready var SpaceShipMesh: MeshInstance = get_node("Cube")

onready var Bullet: Resource = preload("res://Scenes/Bullet.tscn")


func _ready():
	var BulletInstance: KinematicBody = Bullet.instance()
	BulletInstance.global_transform = SpawnBulletPoint.global_transform
	get_parent().add_child(BulletInstance)

func _process(delta):
	var direction: Vector2 = Vector2.ZERO
	direction.x = int(Input.is_action_pressed("Right"))-int(Input.is_action_pressed("Left"))
	direction.y = int(Input.is_action_pressed("Forward"))-int(Input.is_action_pressed("Backward"))
	
	var move: Vector2 = -direction*delta*SPEED
	
	var angle = 0
	if direction.x == 1:
		angle = SpaceShipMesh.rotation.move_toward(Vector3(deg2rad(-20),0,0),delta*ROTSPEED).x
	elif direction.x == -1:
		angle = SpaceShipMesh.rotation.move_toward(Vector3(deg2rad(20),0,0),delta*ROTSPEED).x
	else:
		angle = SpaceShipMesh.rotation.move_toward(Vector3(0,0,0),delta*ROTSPEED).x
	
	SpaceShipMesh.rotation.x = angle
	move_and_slide(Vector3(move.y,0,move.x))
	
	if Input.is_action_just_pressed("Shoot"):
		var BulletInstance: KinematicBody = Bullet.instance()
		BulletInstance.global_transform = SpawnBulletPoint.global_transform
		get_parent().add_child(BulletInstance)
