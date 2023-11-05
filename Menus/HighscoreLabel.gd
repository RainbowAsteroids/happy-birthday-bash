extends Label

func _ready():
	if HighscoreManager.high_score != 0:
		text = text.format([HighscoreManager.high_score])
	else:
		visible = false
