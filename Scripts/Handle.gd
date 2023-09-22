extends MarginContainer

@onready var linkDialog = preload("res://Scenes/link_dialog.tscn")
var filepath : String = ""
var label : String = "New Handle"
var previousValue : String

func _ready():
	Main.handles.append(get_instance_id())
	$"HandleSep/DeleteButton".button_down.connect(_on_delete_button_down)
	$"HandleSep/AttachButton".button_down.connect(_on_attach_button_down)
	set_label(label)
	set_filepath(filepath)
	update_value()

# Updates the text file preview
func update_value():
	if filepath.is_empty():
		return
	previousValue = FileAccess.get_file_as_string(filepath)
	$"HandleSep/HandleValue".text = previousValue


func set_filepath(newPath):
	filepath = newPath
	if(filepath.is_empty()):
		$HandleSep/FilePathScroll/FilePathText.set_text("Unlinked")
		$HandleSep/FilePathScroll/FilePathText.set_modulate(Color(1,0,0,1))
	else:		
		$HandleSep/FilePathScroll/FilePathText.set_text(newPath)
		$HandleSep/FilePathScroll/FilePathText.set_modulate(Color(1,1,1,1))

func set_label(newLabel):
	label = newLabel
	$"HandleSep/HandleTitle".set_text(newLabel)

func get_label():
	return $"HandleSep/HandleTitle".get_text()

# Writes text field to file
func save():
	if(filepath.is_empty()):
		print("%d ignored save" % get_instance_id())
		return
	if($"HandleSep/HandleValue".text == previousValue):
		print("%d ignored save" % get_instance_id())
		return
	var file = FileAccess.open(filepath, FileAccess.WRITE)
	file.store_string($"HandleSep/HandleValue".text)
	file.close()
	previousValue = $"HandleSep/HandleValue".text
	print("%d saved" % get_instance_id())

# Spawns the file dialog to link a handle to a file
func _on_attach_button_down():
	var linkDialogInstance = linkDialog.instantiate()
	if filepath.is_empty():
		linkDialogInstance.current_dir = Main.get_persistent_value("lastLinkDirectory")
	else:
		linkDialogInstance.current_dir = filepath.get_base_dir()
	linkDialogInstance.file_selected.connect(_on_link_confirm)
	add_child(linkDialogInstance)

func _on_link_confirm(newFile):
	var file = newFile.get_file()
	file = file.validate_filename()
	newFile = "%s/%s" % [newFile.get_base_dir(), file]
	Main.set_persistent_value("lastLinkDirectory", newFile.get_base_dir())
	set_filepath(newFile)
	if(not FileAccess.file_exists(newFile)):
		var touch = FileAccess.open(newFile, FileAccess.WRITE)
		if(touch.is_open()):
			touch.close()
		else:
			print("Failure creating file")
	update_value()

func _on_delete_button_down():
	self.queue_free()
	
func _exit_tree():
	Main.handles.erase(get_instance_id())
