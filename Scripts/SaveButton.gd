extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	self.button_down.connect(Main._on_save_button_down)
