extends Node3D

var _plugin_name = "ARCorePlugin"
var _android_plugin

var original_light_trsf: Transform3D;

@export var cube_scene : PackedScene

@onready var camera = $XROrigin3D/XRCamera3D

# Called when the node enters the scene tree for the first time.
func _ready():
	for s in Engine.get_singleton_list():
		print("MCT " + s.get_basename())
	if Engine.has_singleton(_plugin_name):
		print("MCT found plugin")
		_android_plugin = Engine.get_singleton(_plugin_name)
	else:
		printerr("MCT Couldn't find plugin " + _plugin_name)

	print("MCT before initialize_wrapper")
	_android_plugin.initializeEnvironment()

	print("MCT called initialize_wrapper")

	var ar_interface = ARCoreInterfaceInstance.get_interface()
	var interface_name = ar_interface.get_name()
	print("MCT " + interface_name)

	ARCoreInterfaceInstance.start()

	original_light_trsf = $DirectionalLight3D.transform


func _exit_tree():
	_android_plugin.uninitializeEnvironment()


func _on_ui_add_cube():
	var camera_basis = camera.global_transform.basis
	var forward_vector = -camera_basis.z.normalized()
	var position_2m_ahead = camera.global_transform.origin + (forward_vector * 2.0)
	var cube = cube_scene.instantiate()
	cube.basis = camera.basis
	cube.position = position_2m_ahead
	add_child(cube)
