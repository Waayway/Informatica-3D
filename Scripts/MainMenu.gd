extends Spatial

signal replace_main_scene

onready var main: Control = get_node("Main")
onready var loading: Control = get_node("Loading")
onready var options: Control = get_node("Options")

onready var loading_progress: ProgressBar = get_node("Loading/HBoxContainer/ProgressBar")
onready var loading_done_timer: Timer = get_node("Loading/HBoxContainer/LoadingDone")

var res_loader: ResourceInteractiveLoader = null
var loading_thread: Thread = null

func _ready():
	self.connect("replace_main_scene", self, "replace_main_scene")
	get_node("/root/SaveGame").load_game()

func interactive_load(loader):
	while true:
		var status = loader.poll()
		if status == OK:
			loading_progress.value = (loader.get_stage() * 100) / loader.get_stage_count()
			continue
		elif status == ERR_FILE_EOF:
			loading_progress.value = 100
			loading_done_timer.start()
			break
		else:
			print("Error while loading level: " + str(status))
			main.show()
			loading.hide()
			break

func loading_done(loader):
	loading_thread.wait_to_finish()
	emit_signal("replace_main_scene", loader.get_resource())
	res_loader = null

func _on_Play_pressed():
	main.hide()
	loading.show()
	loading_progress.margin_right = 800
	loading_progress.margin_bottom = 53
	var path = "res://Scenes/MainScene.tscn"
	if ResourceLoader.has_cached(path):
		emit_signal("replace_main_scene", ResourceLoader.load(path))
	else:
		res_loader = ResourceLoader.load_interactive(path)
		loading_thread = Thread.new()
		#warning-ignore:return_value_discarded
		loading_thread.start(self, "interactive_load", res_loader)
		#get_tree().change_scene("res://Scenes/MainScene.tscn")


func _on_Quit_pressed():
	get_tree().quit()


func _on_loading_done_timer():
	loading_done(res_loader)
	
func replace_main_scene(resource):
	call_deferred("change_scene", resource)


func change_scene(resource : Resource):
	var node = resource.instance()

	for child in get_children():
		remove_child(child)
		child.queue_free()
	add_child(node)


func _on_Options_pressed():
	options.show()
	main.hide()
	


func _on_Exit_Options_pressed():
	options.hide()
	main.show()


func _on_CheckButton_toggled(button_pressed):
	OS.window_fullscreen = button_pressed
