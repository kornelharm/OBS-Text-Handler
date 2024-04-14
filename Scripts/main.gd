extends Node

@onready var handleScene = preload("res://Scenes/handle.tscn")
@onready var helpScene = preload("res://Scenes/info_dialog.tscn")

var handleList :Node
var handles = []
# Called when the node enters the scene tree for the first time.
func _ready():
	import_persistent_values()
	DisplayServer.window_set_min_size(Vector2i(550,300))
	
# Persistent values, should carry over between sessions
var persistentValues = {
	"lastImportDirectory" : "",
	"lastExportDirectory" : "",
	"lastLinkDirectory" : "",
}


func _on_save_button_down():
	for id in handles:
		var handle = instance_from_id(id)
		handle.save()

func add_handle(label, filepath):
	var handleInstance = handleScene.instantiate()
	handleInstance.filepath = filepath
	handleInstance.label = label
	handleList.add_child(handleInstance)
	handleInstance.get_node("HandleSep/HandleTitle").grab_focus()
	handleInstance.get_node("HandleSep/HandleTitle").select_all()
	
func clear_handle_list():
	for handle in handleList.get_children():
		handle.queue_free()

func _on_new_handle_button_down():
	add_handle("New Handle", "")

func get_persistent_value(keMy):
	return persistentValues[key]

func set_persistent_values(keys : Array, vals : Array):
	var count = 0
	for key in keys:
		persistentValues[key] = vals[count]
		count += 1
	save_persistent_values()

func set_persistent_value(key, val):
	persistentValues[key] = val
	print("\'%s\' set to \'%s\'" % [key, val])
	save_persistent_values()
	
func save_persistent_values():
	var settings = FileAccess.open("user://settings.json", FileAccess.WRITE)
	settings.store_string(JSON.stringify(persistentValues))
	settings.close()

func import_persistent_values():
	if not FileAccess.file_exists("user://settings.json"):
		print("IMPORT: \'settings.json\' has not been created yet")
		return
	var settingsString = FileAccess.get_file_as_string("user://settings.json")
	var settingsJSON = JSON.parse_string(settingsString)
	for key in settingsJSON:
		if key in persistentValues:
			persistentValues[key] = settingsJSON[key]
			print("IMPORT: %s set to %s" % [key,settingsJSON[key]])
			
func draw_help_window():
	var window = helpScene.instantiate()
	self.add_child(window)
