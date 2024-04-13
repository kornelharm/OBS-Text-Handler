extends FileDialog

var topWindow
# Called when the node enters the scene tree for the first time.
func _ready():
	topWindow = get_node("/root/Main").get_window()
	topWindow.size_changed.connect(_on_window_resize)
	max_size = topWindow.get_size()

func _on_window_resize():
	max_size = topWindow.get_size()
