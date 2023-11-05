extends Label

func _ready():
	text = text.format([HighscoreManager.score])
