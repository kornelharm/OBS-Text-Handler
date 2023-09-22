extends Window

func _ready():
	close_requested.connect(_on_close)
	
func _process(_delta):
	# Keep the information window centered to the screen
	size = clamp(size, Vector2i(0,0), DisplayServer.window_get_size())
	set_position((DisplayServer.window_get_size()/2) - size/2)
	
func _on_close():
	self.queue_free()
	

