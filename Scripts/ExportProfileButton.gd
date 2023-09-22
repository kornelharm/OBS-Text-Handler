extends Button

@onready var exportDialog = preload("res://Scenes/export_dialog.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	button_down.connect(_on_export)

func _on_export():
	var exportDialogInstance = exportDialog.instantiate()
	exportDialogInstance.current_dir = Main.get_persistent_value("lastExportDirectory")
	exportDialogInstance.file_selected.connect(Profiler.exportProfile)
	self.add_child(exportDialogInstance)
	
