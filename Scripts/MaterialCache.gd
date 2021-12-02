extends Spatial

var _materials := []
var _process_materials := []
var _count := 0


func _ready() -> void:
	_find_all_materials("res://")
	print(_materials)
	for m in _materials:
		_create_mesh_with(m)
	for p in _process_materials:
		_create_particles_with(p)
	set_process(true)


func _process(delta: float) -> void:
	_count += 1
	if _count > 10:
		set_visible(false)
		set_process(false)


func _find_all_materials(path) -> void:
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin(true, true)
	var path_root = dir.get_current_dir() + "/"

	while true:
		var file = dir.get_next()
		if file == "":
			break
		if dir.current_is_dir():
			_find_all_materials(path_root + file)
			continue
		if not file.ends_with(".tres"):
			continue
		if file.begins_with("m_"):
			_materials.append(path_root + file)
		elif file.begins_with("p_"):
			_process_materials.append(path_root + file)

	dir.list_dir_end()


func _create_mesh_with(material: String) -> void:
	var mesh = PlaneMesh.new()
	var mesh_instance = MeshInstance.new()
	add_child(mesh_instance)

	mesh.set_size(Vector2.ONE)
	mesh.set_material(load(material))
	mesh_instance.set_mesh(mesh)
	mesh_instance.rotation_degrees = Vector3(90, 0.0, 0.0)
	mesh_instance.set_name(material.get_file().split(".")[0])


func _create_particles_with(material: String) -> void:
	var particles = Particles.new()
	var mesh = PlaneMesh.new()
	add_child(particles)

	mesh.set_size(Vector2.ONE)
	particles.process_material = load(material)
	particles.draw_passes = 1
	particles.draw_pass_1 = mesh
	particles.emitting = true
	particles.one_shot = false
	particles.set_name(material.get_file().split(".")[0])
