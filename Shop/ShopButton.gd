class_name ShopButton extends VBoxContainer

@export var weapon_scene: PackedScene
@export var stick := false

@export var initial_price := 20
@export var price_variation := 10

var price: int

@onready var texture_rect = $TextureRect as TextureRect
@onready var price_label = $HBoxContainer/Label as Label

signal selected(button: ShopButton)

func _on_gui_input(event: InputEvent):
	#print("gui_input")
	if event is InputEventMouseButton:
		#print("gui_input mouse btn")
		if event.pressed:
			#print("gui_input mouse btn pressed")
			selected.emit(self)

func _ready():
	reset()
	gui_input.connect(_on_gui_input)

func reset():
	if not stick:
		price = initial_price + randi_range(-price_variation, price_variation)

func _process(_delta):
	price_label.text = str(price)

	if stick:
		price = HighscoreManager.score / 5 + 1
