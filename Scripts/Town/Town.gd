extends StaticBody2D

onready var player = get_node("../Player")
onready var merchantTex = get_node("../Player/Camera2D/MerchantTex")
onready var market = get_node("../Market")
onready var sell = get_node("../Market/Sell")
onready var interaction = get_node("InteractionZone")

func _ready():
	market.visible = false
	pass

func _process(delta):
	# Colliding with town and space pressed (display merchant)
	if(interaction.overlaps_body(player) and Input.is_action_just_pressed("ui_accept")):
		merchantTex.visible= !merchantTex.visible
		market.visible = !market.visible
		# Reset market items
		sell.clear()
		sell._display_crops()

	# Pause if merchant visible
	if(merchantTex.visible):
		pause_mode = Node.PAUSE_MODE_PROCESS
		get_tree().paused=true
	else:
		pause_mode = Node.PAUSE_MODE_STOP
		get_tree().paused=false
	pass
