extends KinematicBody

export var SPEED: float = 1000

func _ready():
	pass

func _process(delta):
	move_and_slide(Vector3(delta*SPEED,0,0))

func _on_Area_area_entered(area):
	get_parent().pause()


func _on_Area2_area_entered(area):
	area.get_parent().queue_free()
	queue_free()
