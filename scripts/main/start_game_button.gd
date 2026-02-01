extends Button

var scenes: Dictionary = {}
var current_scene = Constants.areas.ROOM
@onready var main_menu: Control = $".."

func _on_pressed() -> void:
	main_menu.hide()
	register_scene(Constants.areas.COMPUTER, preload("res://scenes/computer/desk.tscn"))
	register_scene(Constants.areas.ROOM, preload("res://scenes/overworld/overworld.tscn"))	
	register_scene(Constants.areas.WINDOW, preload("res://scenes/window/window_scene.tscn"))
	switch_scene(Constants.areas.ROOM)
	EventBus.switch_scene.connect(switch_scene)
	


func switch_scene(scene):
	# Disabling process mode
	scenes[current_scene].process_mode = Node.PROCESS_MODE_DISABLED
	scenes[current_scene].hide()
	scenes[scene].process_mode = Node.PROCESS_MODE_INHERIT
	scenes[scene].show()
	current_scene = scene
	
func register_scene(name: Constants.areas, packed_scene: PackedScene):
	var scene_instance = packed_scene.instantiate()
	scene_instance.process_mode = Node.PROCESS_MODE_DISABLED
	scene_instance.visible = false
	get_tree().root.add_child.call_deferred(scene_instance)
	scenes[name] = scene_instance
