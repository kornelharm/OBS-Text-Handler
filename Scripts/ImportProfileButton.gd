extends Button

@onready var importDialog = preload("res://Scenes/import_dialog.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	button_down.connect(_on_import)

func _on_import():
	var importDialogInstance = importDialog.instantiate()
	importDialogInstance.current_dir = Main.get_persistent_value("lastImportDirectory")
	importDialogInstance.file_selected.connect(Profiler.importProfile)
	self.add_child(importDialogInstance)
