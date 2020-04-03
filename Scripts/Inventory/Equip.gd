extends Panel

onready var selected = self.get_node("Selected")
onready var equippedText = self.get_node("Label")

func _ready():
	pass

# Set texture for the equipped item
func set_selected_texture(tex:Texture)->void:
	selected.set_texture(tex)

# Set text for the equipped item
func set_label_text(text:String)->void:
	equippedText.set_text(text)