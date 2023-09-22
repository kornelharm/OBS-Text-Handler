extends Button

func _ready():
	self.button_down.connect(Main._on_new_handle_button_down)

func _input(_event):
	if Input.is_action_just_pressed("AddHandle"):
		print("Event")
		Main._on_new_handle_button_down()
