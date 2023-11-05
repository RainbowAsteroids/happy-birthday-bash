extends Label

func _process(_delta):
	text = "Score: " + str(HighscoreManager.score)
