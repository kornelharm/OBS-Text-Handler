extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func importProfile(filepath : String):
	print("Importing profile at \"%s\"" % filepath)
	var profileString = FileAccess.get_file_as_string(filepath)
	var newHandleList : Array = JSON.parse_string(profileString)
	if(newHandleList == null):
		print("Import failed")
	Main.clear_handle_list()
	for handle in newHandleList:
		Main.add_handle(handle["label"], handle["filepath"])
	Main.set_persistent_value("lastImportDirectory", filepath.get_base_dir())
	


func exportProfile(filepath : String):
	var allHandles = []
	for handle in Main.handleList.get_children():
		var encodedHandle = {
			"label" : handle.get_label(),
			"filepath": handle.filepath,
		}
		allHandles.append(encodedHandle)
	var profile = FileAccess.open(filepath, FileAccess.WRITE)
	profile.store_string(JSON.stringify(allHandles))
	profile.close()
	Main.set_persistent_value("lastExportDirectory", filepath.get_base_dir())
	print("Exported profile to \"%s\"" % filepath)
		
		
