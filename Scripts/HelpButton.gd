extends Button

func _ready():
	button_down.connect(Main.draw_help_window)
